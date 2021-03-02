//
//  AddActViewModel.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import Foundation

class AddActViewModel: ObservableObject {
    @Published var actCode: String = ""
    @Published var actDate: Date = Date()
    @Published var historyNote: String = ""
    @Published var physicalExamNote = ""
    @Published var consultingPhysician = ""
    @Published var actLocation: ActLocation?
    @Published var actCategory: ActCategory?
    @Published var ramqAct: RAMQAct?
    @Published var database = RAMQActDatabase(version: "", dateRevision: "", actDatabase: [])
    
    private var episode: MedicalEpisode?
    private var act: Act?
    
    init(act: Act?, episode: MedicalEpisode?){
        self.episode = episode
        self.act = act
        self.fetchJSON{ error in
            if let error = error {
                print(error)
            }
        }
        
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
    
    private func fetchJSON(completionHandler: @escaping (Error?) -> Void) {
        //JSON file is on disk. Open it and import
        let jsonFile = "ramqDB"
        
        //Get file URL from directory on disk
        guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json") else {
            fatalError("Failed to located json file on disk")
        }
        
        // get a data representation of JSON
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file to data from Bundle")
        }
        
        // Decode JSON and import it
        do {
            // Decode JSON into codable type
            let ramqDB = try JSONDecoder().decode(RAMQActDatabase.self, from: data)
            loadBillingCodes(with: ramqDB)
        } catch {
            // Alert user data not digested
            completionHandler(error)
            return
        }
    }
    
    private func loadBillingCodes(with database: RAMQActDatabase){
        self.database = database
    }
}
