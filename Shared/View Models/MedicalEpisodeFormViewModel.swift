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
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var admissionDate: Date?
    @Published var roomLocation: String?
    @Published var list: PatientsList?
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
        //setValues()
    }
    
    func setValues() {
        self.startDate = episode.startDate
        self.endDate = episode.endDate
        self.roomLocation = episode.roomLocation
        self.diagnosis = episode.diagnosis?.wrappedDescription ?? "None"
        self.list = episode.list
        self.admissionDate = episode.admissionDate
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
        self.episode.addToActs(NSSet(array: acts))
        self.episode.saveYourself(in: PersistenceController.shared.container.viewContext)
    }
    
}
