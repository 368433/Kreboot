//
//  PatientFormViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import Foundation
import Combine

class PatientFormViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    private var worklist: WorklistViewModel?
    private var patient: Patient?
    private var newEpisode: Bool = false
    
    @Published var disableForm: Bool = true
    @Published var name: String
    @Published var postalCode: String?
    @Published var chartNumber: String?
    @Published var ramqNumber: String?
    @Published var dateOfBirth: Date?
    
    private var cancellables = Set<AnyCancellable>()
    private var disableFormPublisher: AnyPublisher<Bool, Never> {
        $name
            .map{$0.isEmpty}
            .eraseToAnyPublisher()
    }
    
    init(worklist: WorklistViewModel? = nil, patient: Patient? = nil, newEpisode: Bool = false){
        self.patient = patient
        self.worklist = worklist
        self.newEpisode = newEpisode
        
        self._name = Published(initialValue: self.patient?.name ?? "")
        self._postalCode = Published(initialValue: self.patient?.postalCode)
        self._dateOfBirth = Published(initialValue: self.patient?.dateOfBirth)
        self._chartNumber = Published(initialValue: self.patient?.chartNumber)
        self._ramqNumber = Published(initialValue: self.patient?.ramqNumber)
        
        disableFormPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.disableForm, on: self)
            .store(in: &cancellables)
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
            episode.uniqueID = UUID()
            episode.startDate = Date()
            if let list = worklist?.list {
                list.addToMedicalEpisodes(episode)
            }
        }
        worklist?.updateContent()
        patient.saveYourself(in: viewContext)
    }
}
