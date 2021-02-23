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
    
    var cardsFilter: EpisodeFilterEnum = .toSee {
        didSet{
            setList()
        }
    }
    var cardsSort: EpisodeSortEnum = .name {
        didSet{
            setList()
        }
    }
    @Published var episodesList: [MedicalEpisode] = []

    @FetchRequest(entity: MedicalEpisode.entity(), sortDescriptors: [])
    private var cdList: FetchedResults<MedicalEpisode>
    
    private var cancellables = Set<AnyCancellable>()


    var isEmpty: Bool { return list == nil }
    var listTitle: String { return list?.title ?? "Untiltled list"}
    
    
    init(patientsList list: PatientsList? = nil){
        self.list = list
        setList()
        
        $list
            .map{$0?.uniqueID?.uuidString}
            .sink{ uniqueID in
                UserDefaults.standard.set(uniqueID, forKey: "lastListSelected")
            }
            .store(in: &cancellables)
    }
    
    private func setList() {
        self.episodesList = list?.getEpisodeList(filteredBy: cardsFilter, sortedBy: cardsSort) ?? []
    }
    
}
