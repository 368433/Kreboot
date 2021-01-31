//
//  PatientRow2.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct PatientRow2: View {
    @ObservedObject var patient: Patient
    
    var body: some View {
        HStack {
            VStack (alignment:.leading){
                Text(patient.name ?? "No name").foregroundColor(.primary)
                Text("ramqnumber").foregroundColor(.secondary).font(.footnote)
            }
            Spacer()
            Button(action: {}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}
        }.padding().background(Color.white).cornerRadius(3.0).padding().shadow(radius: 5)
    }
}

struct PatientRow2_Previews: PreviewProvider {
    static var previews: some View {
        PatientRow2(patient: PersistenceController.singlePatient)
    }
}
