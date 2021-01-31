//
//  PatientRowAddView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct PatientRowAddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var patient: Patient
    var list: PatientsList
    
    @State var rowTapped: Bool = false
    
    private var isInList: Bool {
        return list.patientsArray.contains(patient)
    }
    
    var body: some View {
        HStack{
            Text(patient.name ?? "No name")
            Spacer()
            Button(action: addPatient, label: {
                Image(systemName: isInList ? "checkmark.circle.fill":"plus.circle")
            })
        }
            .onTapGesture {addPatient()}
    }
    private func addPatient(){
        if isInList {
            list.removeFromPatients(patient)
        } else {
            list.addToPatients(patient)
        }
        list.saveYourself(in: viewContext)
        rowTapped.toggle()
    }
}

struct PatientRowAddView_Previews: PreviewProvider {
    static var previews: some View {
        PatientRowAddView(patient: PersistenceController.singlePatient, list: PersistenceController.singleList)
    }
}
