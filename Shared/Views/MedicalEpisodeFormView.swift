//
//  MedicalEpisodeFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import SwiftUI

class MedicalEpisodeFormViewModel: ObservableObject {
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var roomLocation: String?
    @Published var diagnosis: ICD10dx?
    @Published var patient: Patient?
    @Published var list: PatientsList?
    @Published var acts: [Act]?
    
//    let episode: MedicalEpisode?

}

struct MedicalEpisodeFormView: View {
    var body: some View {
        Form{
            
        }
    }
}

struct MedicalEpisodeFormView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalEpisodeFormView()
    }
}
