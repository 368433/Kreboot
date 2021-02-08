//
//  PatientRow2.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct PatientRow2: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var patient: Patient
    @State private var showFullCard: Bool = false
    var dxAction: () -> Void
    
    var body: some View {
            HStack (alignment: .top){
                VStack{
                    HStack (alignment: .center) {
                        Button(action: {}, label: {Image(systemName: "person.crop.circle.fill")})
                        Text(patient.name ?? "No name").foregroundColor(.primary).fontWeight(.semibold)
                        Spacer()
                        Button(action: dxAction){ Text("Diagnosis").font(.footnote)}.buttonStyle(TightOutlineButton())
                    }
                    Spacer()
                    HStack{
                        Group{
                            Label("room", systemImage: "bed.double")
                            Label("#00000", systemImage: "folder")
                            Label("Last seen", systemImage: "clock")
                        }.foregroundColor(.secondary).font(.caption).lineLimit(1)
                    }
                }
                Spacer()
                Button(action: {}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}.padding(.leading)
                    
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
        PatientRow2(patient: PersistenceController.singlePatient, dxAction: {})
    }
}
