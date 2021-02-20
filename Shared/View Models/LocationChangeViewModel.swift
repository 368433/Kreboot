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
    private var episode: MedicalEpisode?
    
    init(episode: MedicalEpisode?){
        self.episode = episode
        self._currentRoom = Published(initialValue: self.episode?.roomLocation ?? "Not available")
    }
    func save(){
        guard let episode = episode else {return}
        episode.roomLocation = newRoom
        episode.saveYourself(in: PersistenceController.shared.container.viewContext)
    }
}
