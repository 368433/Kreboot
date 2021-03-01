//
//  MedicalEpisodeFormViewModel.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI
import Combine

class MedicalEpisodeFormViewModel: ObservableObject {
    //Medical Episode object attribute
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var admissionDate: Date
    @Published private(set) var roomLocation: String?
    @Published var newRoom: String = ""
    @Published var acts: [Act] = []

    //Medical Episode relationships or related
    @Published var diagnosis: String = ""
    @Published var patientName: String = ""
    @Published private(set) var patient: Patient?

    @ObservedObject private(set) var episode: MedicalEpisode
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(episode: MedicalEpisode) {
        self.episode = episode
        self.patient = episode.patient
        self.startDate = episode.startDate ?? Date()
        self.endDate = episode.endDate ?? Date()
        self.admissionDate = episode.admissionDate ?? Date()
    }
    
    func setValues() {
        self.roomLocation = episode.roomLocation
        self.diagnosis = episode.diagnosis?.wrappedDescription ?? "None"
        self.patientName = patient?.name ?? "N/A"
        self.acts = episode.actList()
    }
    
    func remove(at offsets: IndexSet){
        let deletedActs = offsets.map{ acts.remove(at: $0)}
        self.episode.removeFromActs(NSSet(array: deletedActs))
    }
    
    func saveForm(){
        self.episode.startDate = self.startDate
        self.episode.endDate = self.endDate
        self.episode.admissionDate = self.admissionDate
        if !newRoom.isEmpty {
            self.episode.roomLocation = newRoom
        }
        self.episode.addToActs(NSSet(array: acts))
        self.episode.saveYourself(in: PersistenceController.shared.container.viewContext)
    }
    
}
