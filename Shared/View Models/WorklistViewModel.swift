//
//  WorklistViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import SwiftUI
import Combine

class WorklistViewModel: ObservableObject {
    @Published var list: PatientsList?
    
    @Published var selectedCard: Patient? = nil
    @Published var selectedAct: Act? = nil
    @Published var selectedEpisode: MedicalEpisode? = nil
    
    @Published var activeSheet: ActiveSheet? = nil
    @Published var hideActionButton: Bool = false
    
    @Published var cardsFilter: EpisodeFilterEnum = .toSee
    @Published var cardsSort: EpisodeSortEnum = .name
    
    var episodesList: [MedicalEpisode] = []
    
    private var cancellables = Set<AnyCancellable>()

    var isEmpty: Bool { return list == nil }
    var listTitle: String { return list?.title ?? "Untiltled list"}
    
    init(patientsList list: PatientsList? = nil){
        self.list = list
        
        $list
            .map{$0?.uniqueID?.uuidString}
            .sink{ uniqueID in
                UserDefaults.standard.set(uniqueID, forKey: "lastListSelected")
            }
            .store(in: &cancellables)
    }
    
    func updateList(){
        
    }
    func getList() -> [MedicalEpisode] {
        guard let list = list else { return []}
        let results = list.getEpisodeList(filteredBy: cardsFilter, sortedBy: cardsSort)
        self.episodesList = results
        return results
    }
    
}
