//
//  AddActViewModel.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import Foundation

class AddActViewModel: ObservableObject {
    @Published var searchActText: String = ""
    @Published var actCode: String = ""
    @Published var actDate: Date = Date()
    @Published var historyNote: String = ""
    @Published var physicalExamNote = ""
    @Published var consultingPhysician = ""
    private var episode: MedicalEpisode?
    private var act: Act?
    
    init(act: Act?, episode: MedicalEpisode?){
        self.episode = episode
        self.act = act
        
        self._actCode = Published(initialValue: self.act?.ramqCode ?? "")
        self._actDate = Published(initialValue: self.act?.timestamp ?? Date())
    }
    
    func saveAct(){
        guard !actCode.isEmpty else {return}
        let context = PersistenceController.shared.container.viewContext
        let actToSave = act ?? Act(context: context)
        actToSave.ramqCode = self.actCode
        actToSave.timestamp = self.actDate
        if let episode = episode {
            actToSave.medicalEpisode = episode
        }
        actToSave.saveYourself(in: context)
    }
}
