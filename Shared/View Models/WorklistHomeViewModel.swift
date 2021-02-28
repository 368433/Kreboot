//
//  WorklistHomeViewModel.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import Foundation
import CoreData

class WorklistHomeViewModel: ObservableObject {
    @Published var lastOpenedList: PatientsList?
    @Published var listGroup: ListFilterEnum = .active
    @Published var lists: [PatientsList] = []
    @Published var selectedList: PatientsList? = nil
    @Published var sheetToPresent: wlHomeSheets? = nil
    
    var showLastList: Bool {
        return UserDefaults.standard.bool(forKey: "showLastList")
    }
    
    func getLastOpenedList() -> PatientsList?{
        if let uniqueID = UserDefaults.standard.string(forKey: "lastListSelected") {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
            request.predicate = NSPredicate(format: "uniqueID == %@", uniqueID)
            do {
                return try PersistenceController.shared.container.viewContext.fetch(request).first as? PatientsList
            } catch {print(error)}
        }
        return nil
    }
    
    func getList() -> [PatientsList] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
        request.predicate = listGroup.predicate
        request.sortDescriptors = listGroup.descriptors
        do {
            return try PersistenceController.shared.container.viewContext.fetch(request) as? [PatientsList] ?? []
        } catch {
            print(error)
        }
        return []
    }
    
    func setList() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
        request.predicate = listGroup.predicate
        request.sortDescriptors = listGroup.descriptors
        do {
            self.lists = try PersistenceController.shared.container.viewContext.fetch(request) as? [PatientsList] ?? []
        } catch {
            print(error)
        }
    }
}
