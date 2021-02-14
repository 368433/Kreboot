//
//  PatientFormViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import Foundation

class PatientFormViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    private var list: PatientsList?
    private var patient: Patient?
    private var newEpisode: Bool = false
    
    @Published var disableForm: Bool = true
    @Published var name: String
    @Published var postalCode: String
    @Published var chartNumber: String
    @Published var ramqNumber: String
    @Published var dateOfBirth: Date
    
    init(list: PatientsList? = nil, patient: Patient? = nil, newEpisode: Bool = false){
        self.patient = patient
        self.list = list
        self.newEpisode = newEpisode
        
        self._name = Published(initialValue: self.patient?.name ?? "")
        self._postalCode = Published(initialValue: self.patient?.postalCode ?? "")
        self._dateOfBirth = Published(initialValue: self.patient?.dateOfBirth ?? Date())
        self._chartNumber = Published(initialValue: self.patient?.chartNumber ?? "")
        self._ramqNumber = Published(initialValue: self.patient?.ramqNumber ?? "")
    }
    
    func save(){
        let patient = self.patient ?? Patient(context: viewContext)
        patient.name = name
        patient.postalCode = postalCode
        patient.chartNumber = chartNumber
        patient.ramqNumber = ramqNumber
        patient.dateOfBirth = dateOfBirth
        
        if newEpisode {
            let episode = MedicalEpisode(context: viewContext)
            episode.patient = patient
            if let list = list {
                list.addToMedicalEpisodes(episode)
            }
        }
        patient.saveYourself(in: viewContext)
    }
}
