//
//  PatientRowView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientRowView: View {
    @ObservedObject var patient: Patient
    
    var body: some View {
        HStack {
            VStack (alignment:.leading){
                Text(patient.name ?? "No name").foregroundColor(.primary)
                Text("ramqnumber").foregroundColor(.secondary).font(.footnote)
            }
            Spacer()
            Button(action: {}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}
        }
    }
}

struct PatientRowView_Previews: PreviewProvider {
    static var previews: some View {
        let patient = Patient(context: PersistenceController.preview.container.viewContext)
        patient.name = "test"
        return PatientRowView(patient: patient)
    }
}
