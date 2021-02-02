//
//  ICDProvider.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-02.
//

import CoreData


class ICDCodesProvider2 {
    
    // MARK Core Data
    
    /**
     Set up persistent container
     */
    
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
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
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
        print("\(Date()) Start fetching data from server ...")
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
            
            if let batchInsertResult = try? taskContext.execute(batchInsert) as? NSBatchDeleteResult,
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

