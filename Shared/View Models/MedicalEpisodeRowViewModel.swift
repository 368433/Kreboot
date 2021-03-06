//
//  MedicalEpisodeRowViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-16.
//

import SwiftUI

class MedicalEpisodeRowViewModel: ObservableObject {
    
    @Published var episode: MedicalEpisode
    
    @Published var diagnosis: String
    @Published var patientName: String
    @Published var patientAge: String
    @Published var roomNumber: String
    @Published var flaggedEpisode: Bool
    @Published var chartNumber: String

    
    @Published var worklistModel: WorklistViewModel
    
    init(episode: MedicalEpisode, worklistmodel:WorklistViewModel){
        self.episode = episode
        self.worklistModel = worklistmodel
        self.diagnosis = episode.diagnosis?.icd10Description ?? "Diagnosis"
        self.patientName = episode.patient?.name ?? "N/A"
        self.roomNumber = episode.roomLocation ?? "room"
        self.flaggedEpisode = episode.flagged
        self.patientAge = episode.patient?.ageString ?? "N/A"
        self.chartNumber = episode.patient?.chartNumber ?? "N/A"
    }

    func saveRoom(_ newRoom: String){
        if !newRoom.isEmpty {
            roomNumber = newRoom
            episode.roomLocation = newRoom
            episode.saveYourself(in: PersistenceController.shared.container.viewContext)
        }
    }
    
    func chooseRoom(){
        worklistModel.selectedEpisode = episode
//        worklistModel.activeSheet = .editRoom
        worklistModel.showRoomEdit()
    }
//    func editPatient(){
//        worklistModel.activeSheet = .showIdCard; worklistModel.selectedEpisode = episode
//    }
    
    func addAct(){
        worklistModel.activeSheet = .addAct
        worklistModel.selectedEpisode = episode
    }
    
    func flagEpisode(){
        self.flaggedEpisode.toggle()
        self.episode.flagged = flaggedEpisode
        self.episode.saveYourself(in: PersistenceController.shared.container.viewContext)
    }
}
