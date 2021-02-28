//
//  LocationChangeViewModel.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-19.
//

import Foundation

class LocationChangeViewModel: ObservableObject {
    @Published var currentRoom: String
    @Published var newRoom: String = ""
    var worklistModel: WorklistViewModel?
    private var episode: MedicalEpisode
    
    init(episode: MedicalEpisode, wlModel: WorklistViewModel?){
        self.episode = episode
        self.worklistModel = wlModel
        self.currentRoom = self.episode.roomLocation ?? "Not available"
    }
    
    func save(){
        if !newRoom.isEmpty {
            episode.roomLocation = newRoom
            episode.saveYourself(in: PersistenceController.shared.container.viewContext)
        }
        if let worklistModel = worklistModel {
            worklistModel.hideRoomEdit()
        }
    }
    
}
