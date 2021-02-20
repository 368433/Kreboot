//
//  ActiveSheet.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case addAct, showAllLists, addPatient, searchPatients, editListDetails, medicalEpisodeFormView, editRoom
    
    var id: Int {
        hashValue
    }
}


/**
 case .setDiagnosis:
     DiagnosisSearchView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
 case .showIdCard:
     NavigationView{PatientFormView(patient: model.selectedEpisode?.patient, newEpisode: false)}.environment(\.managedObjectContext, self.viewContext)
 case .editRoom:
     RoomChangeView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
 case .actFormView:
     ActFormView(for: model.selectedAct, in: nil).environment(\.managedObjectContext, self.viewContext)
 
 */
