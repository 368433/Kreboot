//
//  WorklistViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import SwiftUI

class WorklistViewModel: ObservableObject {
    @Published var list: PatientsList? = nil
    @Published var selectedCard: Patient? = nil
    @Published var selectedEpisode: MedicalEpisode? = nil
    @Published var activeSheet: ActiveSheet? = nil
//    @Published var medicalEpisodes: [Patient] = []
    
    var isEmpty: Bool {
        return list == nil
    }
    var listTitle: String {
        return list?.title ?? "Untiltled list"
    }
    
    var medicalEpisodes: [MedicalEpisode] {
        //TODO: convert to function and add a predicate and sorting option
        guard let list = list else {return []}
        let episodes = list.medicalEpisodes as? Set<MedicalEpisode> ?? []
        return Array(episodes)
    }
    var patientsList: [Patient] {
        guard let list = list else {return []}
        return list.patientsArray
    }
}
