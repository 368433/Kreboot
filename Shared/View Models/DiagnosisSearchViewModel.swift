//
//  DiagnosisSearchViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-14.
/**
 with help from https://medium.com/better-programming/search-bar-and-combine-in-swift-ui-46f37cec5a9f
 and other readings
 */

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
    private var episode: MedicalEpisode?
    
    init(episode: MedicalEpisode?){
        self.episode = episode
        
        //setup publisher to subscriber channel
        $searchString
            //Set throttle to avoid overloading queries
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            
            //convert search string to array of words
            //then return array of predicates from words
            .map{ searchWords -> [NSPredicate] in
                if searchWords.isEmpty{ return [] }
                return searchWords.split(whereSeparator: \.isLetter.negation).map{NSPredicate(format:"icd10Description CONTAINS[cd] %@" , String($0))}
            }
            .sink { predicates in
                if predicates.isEmpty {
                    self.searchResults = []
                } else {
                    self.request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                    self.request.sortDescriptors = [self.sortDescriptor]
                    do {
                        self.searchResults = try self.moc.fetch(self.request)
                    } catch {
                        print(error)
                    }
                }
            }
            .store(in: &subscription)
    }
    
    func assignToEpisode(diagnosis: ICD10dx){
        guard let episode = episode else {return}
        episode.diagnosis = diagnosis
        episode.saveYourself(in: PersistenceController.shared.container.viewContext)
        
    }
}
