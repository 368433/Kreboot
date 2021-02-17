//
//  MedicalEpisodeRowViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-16.
//

import SwiftUI

class MedicalEpisodeRowViewModel: ObservableObject {
    static let collapsedHeight: CGFloat = 100
    static let expandedHeight: CGFloat = 350
    
    @Published var episode: MedicalEpisode
    
    @Published var diagnosis: String
    @Published var patientName: String
    @Published var roomNumber: String

    
    @Published var worklistModel: WorklistViewModel
    
    init(episode: MedicalEpisode, worklistmodel:WorklistViewModel){
        self.episode = episode
        self.worklistModel = worklistmodel
        self.diagnosis = episode.diagnosis?.icd10Description ?? "Diagnosis"
        self.patientName = episode.patient?.name ?? "No name"
        self.roomNumber = episode.roomLocation ?? "room"
    }
    
    func chooseDiagnosis(){
        worklistModel.activeSheet = .showIdCard
        worklistModel.selectedEpisode = episode
    }
    
    func chooseRoom(){
        worklistModel.activeSheet = .editRoom; worklistModel.selectedEpisode = episode
    }
    func editPatient(){
        worklistModel.activeSheet = .showIdCard; worklistModel.selectedEpisode = episode
    }
    func addAct(){
        worklistModel.activeSheet = .addAct; worklistModel.selectedEpisode = episode
    }
}
