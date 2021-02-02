//
//  ICDProvider3.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-02.
//

import CoreData


class ICDCodesProvider3: ObservableObject {
    
    @Published public var dataResults = [ICD10dx]()
    
    // MARK Core Data
    
    /**
     Set up persistent container
     */
  
//    var persistentContainer = PersistenceController.shared.container
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Kreboot")

        if #available(iOS 13, macOS 10.15, *){
            // Enable remote notifications
            guard let description = container.persistentStoreDescriptions.first else {
                fatalError("Failed to retrieve a persistent store description")
            }
            description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        }

        container.loadPersistentStores { (storeDescription, error) in
            guard error == nil else { fatalError("Unresolved error \(error!)")}
        }

        // refresh UI by refetching data, so doesn't need to merge the changes.
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true

        if #available(iOS 13, macOS 10.15, *){
            // Observe Core Data remote change notifications.
            NotificationCenter.default.addObserver(
                self, selector: #selector(type(of: self).storeRemoteChange(_:)),
                name: .NSPersistentStoreRemoteChange, object: nil)
        }

        return container
    }()
    
    /**
        Creates and configures a private queue context
     */
    private func newTaskContext() -> NSManagedObjectContext {
        // Create a priavte queue context.
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        // Set unused undoManager to nil for macOS to reduce resource
        taskContext.undoManager = nil
        return taskContext
    }
    
    /**
     JSON file is already on disc
     opens JSON file from disk and imports into Core Data
     */
    
    func fetchICDCodes(completionHandler: @escaping (Error?) -> Void) {
        
        // JSON file name on disc
        let JSONfile = "icd10_codes"

        // Get file URL
        guard let url = Bundle.main.url(forResource: JSONfile, withExtension: ".json") else {
            fatalError("Failed to locate file in bundle")
        }
        
        // Get a data representation of JSON
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file from bundle")
        }
        
        // Decode the JSON and import it into Core Data
        print("\(Date()) Start fetching data from file ...")
        do {
            // Decode the JSON into codable type ICDJSON
            let icdJSON = try JSONDecoder().decode(ICDJSON.self, from: data)
            print("\(Date()) Got \(icdJSON.icdCodesList.count) records")
            
            print("\(Date()) Start importing data to the store ...")
            //Import the ICDJSON into Core Data
            if #available(iOS 13, macOS 10.15, *) {
                try self.importICDCodesUsingBIR(from: icdJSON)
            } else {
                fatalError("Unsupported plateform. Requires iOS 13 and more")
            }
            print("\(Date()) Finished importing data.")
        } catch {
            // Alert the user if data cannot be digested.
            completionHandler(error)
            return
        }
        completionHandler(nil)

    }
    
    @available(iOS 13, macOS 10.15, *)
    private func importICDCodesUsingBIR(from icdJSON: ICDJSON) throws {
        guard !icdJSON.icdCodesList.isEmpty else {return}
        
        var performError: Error?
        
        // taskContext.performAndWait runs on a delegate queue *** FIND OUT HOW TO CREATE A DELEGATE QUEUE
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let batchInsert = self.newBatchInsertRequest(with: icdJSON.icdCodesList)
            batchInsert.resultType = .statusOnly
            
            if let batchInsertResult = try? taskContext.execute(batchInsert) as? NSBatchInsertResult,
               let success = batchInsertResult.result as? Bool, success {
                return
            }
            performError = ICDError.batchInsertError
        }
        
        if let error =  performError {
            throw error
        }
    }
    
    @available(iOS 13, macOS 10.15, *)
    private func newBatchInsertRequest(with icdCodesList: [[String: String]]) -> NSBatchInsertRequest {
        let batchInsert: NSBatchInsertRequest
//        if #available(iOS 14, macOS 10.16, *) {
            // Provide one dictionary at a time when the block is called
            var index = 0
            let total = icdCodesList.count
            batchInsert = NSBatchInsertRequest(entityName: "ICD10dx", dictionaryHandler: { (dictionary) -> Bool in
                guard index < total else { return true }
                dictionary.addEntries(from: icdCodesList[index])
                index += 1
                return false
            })
//        } else {
//            // Provide the dictionaries all together.
//            batchInsert = NSBatchInsertRequest(entityName: "ICD10dx", objects: icdCodesList)
//        }
        return batchInsert
    }
    
    /**
     Deletes all the records in the Core Data store.
    */
    func deleteAll(completionHandler: @escaping (Error?) -> Void) {
        let taskContext = newTaskContext()
        
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ICD10dx")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            
            // Execute the batch delete
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult,
               batchDeleteResult.result != nil {
                completionHandler(nil)
            } else {
                completionHandler(ICDError.batchDeleteError)
            }
        }
    }
    
    // MY Implementation of fetchedresults to serve data to view
    
    // MARK: - NSFetchedResultsController
    
    /**
     A fetched results controller delegate to give consumers a chance to update
     the user interface when content changes.
     */
    
    weak var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?

    /**
     A fetched results controller to fetch Quake records sorted by time.
     */
    lazy var fetchedResultsController: NSFetchedResultsController<ICD10dx> = {
        
        // Create a fetch request for the Quake entity sorted by time.
        let fetchRequest = NSFetchRequest<ICD10dx>(entityName: "ICD10dx")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "icd10Code", ascending: true)]
        fetchRequest.propertiesToFetch = ["icd10Code", "icd10Description"]
        // Create a fetched results controller and set its fetch request, context, and delegate.
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: persistentContainer.viewContext,
                                                    sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = fetchedResultsControllerDelegate
        
        // Perform the fetch.
        do {
            try controller.performFetch()
        } catch {
            fatalError("Unresolved error \(error)")
        }
        return controller
    }()
    
    
    /**
     Resets viewContext and refetches the data from the store.
     */
    func resetAndRefetch() {
        persistentContainer.viewContext.reset()
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Unresolved error \(error)")
        }
    }

    
    // MARK: - NSPersistentStoreRemoteChange handler

    /**
     Handles remote store change notifications (.NSPersistentStoreRemoteChange).
     storeRemoteChange runs on the queue where the changes were made.
     */
    @objc
    func storeRemoteChange(_ notification: Notification) {
        // print("\(#function): Got a persistent store remote change notification!")
    }
}

