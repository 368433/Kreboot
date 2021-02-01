//
//  PatientRow2.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct PatientRow2: View {
    @ObservedObject var patient: Patient
    
    @State private var showFullCard: Bool = false
    
    var body: some View {
        VStack (alignment:.leading){
            HStack (alignment: .top){
                VStack (alignment:.center, spacing: 5){
                    HStack (alignment: .bottom) {
                        Text(patient.name ?? "No name").foregroundColor(.primary).fontWeight(.semibold)
                        Spacer()
                        Text("Diagnosis").font(.callout)
                    }
                    HStack{
                        HStack (spacing: 2){
                            Image(systemName: "bed.double")
                            Text("room")
                        }.foregroundColor(.secondary).font(.caption)
                        HStack (spacing: 2){
                            Image(systemName: "folder")
                            Text("#00000")
                        }.foregroundColor(.secondary).font(.caption)
                        HStack (spacing: 2){
                            Image(systemName: "clock")
                            Text("Last seen")
                        }.foregroundColor(.secondary).font(.caption)
                    }.lineLimit(1)
                    Spacer()
                }
                Spacer()
                Button(action: {}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}.padding(.leading)
            }
        }.padding()
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color.black.opacity(0.2), radius: 10)
        .onTapGesture {
            showFullCard.toggle()
        }
        .frame(height: showFullCard ? 400:80)
        .animation(.easeInOut(duration: 0.2))
    }
}

struct PatientRow2_Previews: PreviewProvider {
    static var previews: some View {
        PatientRow2(patient: PersistenceController.singlePatient)
    }
}
