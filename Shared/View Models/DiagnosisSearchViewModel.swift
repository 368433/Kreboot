//
//  DiagnosisSearchViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-14.
//

import Combine
import CoreData

class DiagnosisSearchViewModel: ObservableObject {
    @Published var searchResults: [ICD10dx] = []
    @Published var searchString: String = ""
    
    private var moc = PersistenceController.shared.container.viewContext
    private var sortDescriptor = NSSortDescriptor(keyPath: \ICD10dx.icd10Code, ascending: true)
    private var searchPredicate: NSPredicate? = nil
    private var subscription = Set<AnyCancellable>()
    private var request: NSFetchRequest<ICD10dx> = {
        let request = NSFetchRequest<ICD10dx>(entityName: "ICD10dx")
        request.fetchOffset = 0
        request.fetchBatchSize = 100
        request.fetchLimit = 500
        return request
    }()
    
    init(){
        //setup publisher to subscriber channel
        $searchString
            //Set throttle to avoid overloading queries
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            //convert search string to predicate
            .map{NSPredicate(format: "icd10Description CONTAINS[cd] %@", $0)}
            //generate coredata search request and fetch and assign result to search result array
            .sink { predicate in
                self.request.predicate = predicate
                self.request.sortDescriptors = [self.sortDescriptor]
                do {
                    self.searchResults = try self.moc.fetch(self.request)
                } catch {
                    print(error)
                }
            }
            .store(in: &subscription)
    }
}
