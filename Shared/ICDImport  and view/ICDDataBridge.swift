//
//  ICDDataBridge.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-02.
//

import CoreData
import SwiftUI

class ICDDataBridge: NSObject, ObservableObject {
    @Published var icdList = [ICD10dx]()
    @StateObject var provider = ICDCodesProvider3()
    
    init(managedObjectContext: NSManagedObjectContext){
        super.init()
        provider.fetchedResultsControllerDelegate = self
    }
}

extension ICDDataBridge: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let newList = controller.fetchedObjects as? [ICD10dx] else {return}
        icdList = newList
    }
}
