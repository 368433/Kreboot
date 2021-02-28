//
//  MedicalEpisodeFormViewModel.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI
import Combine

class MedicalEpisodeFormViewModel: ObservableObject {
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var roomLocation: String?
    @Published var diagnosis: ICD10dx?
    @Published var list: PatientsList?
    @Published var acts: [Act]?
    @Published var hospitalizedDate: Date?
    @Published var patientName: String = ""
    
    @ObservedObject var episode: MedicalEpisode
    @Published var patient: Patient
    private var subscriptions = Set<AnyCancellable>()
    
    init(episode: MedicalEpisode) throws {
        self.episode = episode
        guard let patient = episode.patient else {throw KarlaError.noPatient}
        self.patient = patient
    }
    
}
