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
        VStack (alignment:.leading){
            Text("room").foregroundColor(.secondary).font(.caption).padding(.top, 3)
            HStack {
                VStack (alignment:.leading){
                    HStack (alignment: .bottom) {
                        Text(patient.name ?? "No name").foregroundColor(.primary)
                        Spacer()
                        Text("Diagnosis").font(.callout)
                    }
                    HStack (alignment: .top){
                        Text("chart number")
                        Spacer()
                        Text("ramqnumber")
                    }.foregroundColor(.secondary).font(.caption)
                }
                Spacer()
                Button(action: {}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}.padding(.leading)
            }
        }.padding([.leading,.bottom,.trailing])
        .background(Color.white)
        .cornerRadius(10.0)
        //.padding()
        .shadow(color: Color.black.opacity(0.2), radius: 10)
        .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
    }
}

struct PatientRow2_Previews: PreviewProvider {
    static var previews: some View {
        PatientRow2(patient: PersistenceController.singlePatient)
    }
}
