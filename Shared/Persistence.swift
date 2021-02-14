//
//  Persistence.swift
//  Shared
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        //Generating sample patients
        for _ in 0..<10 {
            let newPatient = Patient(context: viewContext)
            newPatient.name = "A dude" + String(Int.random(in: 10..<200))
            newPatient.ramqNumber = String(Int.random(in: 1000000..<99999999))
        }
        
        //Generating sample lists
        for _ in 0..<10 {
            let newList = PatientsList(context: viewContext)
            newList.title = "List number " +  String(Int.random(in: 10..<200))
            newList.isFavorite = Int.random(in: 0..<2) == 0 ? false:true
            newList.isArchived = Int.random(in: 0..<4) == 0 ? false:true
            newList.dateCreated = Date(timeIntervalSince1970: Double.random(in: 0..<10000000))
        }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    static var singlePatient: Patient {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let pt = Patient(context: viewContext)
        pt.name = "Thelonius Monk"
        do {
            try viewContext.save()
        }
        catch {
            
        }
        return pt
    }
    
    static var singleMedicalEpisode: MedicalEpisode {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let episode = MedicalEpisode(context: viewContext)
        episode.patient = singlePatient
        episode.startDate = Date()
        episode.referringMD = "Bob squidward"
        episode.roomLocation = "dasha"
        do {
            try viewContext.save()
        } catch {
            
        }
        
        return episode
    }
    
    static var singleList: PatientsList {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let singleList = PatientsList(context: viewContext)
        singleList.title = "You don't know what love is"
        singleList.dateCreated = Date()
        //create linked patients
        for _ in 0..<10 {
            let newPatient = Patient(context: viewContext)
            newPatient.name = "A dude" + String(Int.random(in: 10..<50))
            newPatient.ramqNumber = String(Int.random(in: 1000000..<99999999))
            singleList.addToPatients(newPatient)
        }
        do {
            try viewContext.save()
        }
        catch {
            
        }
        return singleList
    }
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Kreboot")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
