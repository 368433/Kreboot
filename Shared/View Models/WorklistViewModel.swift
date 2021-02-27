//
//  WorklistViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import SwiftUI
import Combine

class WorklistViewModel: ObservableObject {
    @Published var list: PatientsList
    
    @Published var selectedCard: Patient? = nil
    @Published var selectedAct: Act? = nil
    @Published var selectedEpisode: MedicalEpisode? = nil
    
    @Published var activeSheet: ActiveSheet? = nil
    @Published var hideActionButton: Bool = false
    @Published private(set) var editRoom: Bool = false
    @Published var showFilter: Bool = false
    
    @Published var cardsFilter: EpisodeFilterEnum = .toSee
    @Published var cardsSort: EpisodeSortEnum = .name
    
    var episodesList: [MedicalEpisode] = []
    
    private var cancellables = Set<AnyCancellable>()

    var listTitle: String { return list.title ?? "Untiltled list"}
    
    init(patientsList list: PatientsList){
        self.list = list
        
        $list
            .map{$0.uniqueID?.uuidString}
            .sink{ uniqueID in
                UserDefaults.standard.set(uniqueID, forKey: "lastListSelected")
            }
            .store(in: &cancellables)
    }
    
    func updateList(){
        
    }
    func getList() -> [MedicalEpisode] {
        let results = list.getEpisodeList(filteredBy: cardsFilter, sortedBy: cardsSort)
        self.episodesList = results
        return results
    }
    
    func showRoomEdit(){
        if editRoom {
            editRoom.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + Karla.animationSpeed + 0.01) {
                self.editRoom.toggle()
            }
            
        } else {
            editRoom.toggle()
        }
    }
    
    func hideRoomEdit(){
        if editRoom {
            editRoom.toggle()
        }
    }
    
}
