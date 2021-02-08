//
//  PatientFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var patient: Patient
    var list: PatientsList?
    var disableSave: Bool {
        return patient.name?.isEmpty ?? true
    }
    
    init(patient: Patient? = nil, list: PatientsList? = nil){
        self.patient = patient ?? Patient(context: PersistenceController.shared.container.viewContext)
        self.list = list
    }
    
    var body: some View {
        List {
            Section( header: VStack(alignment: .leading){
                HStack {
                    Spacer()
                    Button(action: {}){Image(systemName: "doc.text.viewfinder")}.buttonStyle(CircularButton()).padding(.top)
                }
                Text("Personnal data")
            }) {
                TextField("Name", text: $patient.name ?? "")
                TextField("PostalCode", text: $patient.postalCode ?? "")
                HStack{
                    Text("Card photo")
                    Spacer()
                    Image(systemName: "person.crop.rectangle")
                }
                DatePicker("Date of Birth", selection: $patient.dateOfBirth ?? Date(), displayedComponents: .date)
            }
            Section(header: Text("Healthcare system Data")) {
                TextField("RAMQ", text: $patient.ramqNumber ?? "")
                TextField("Chart number", text: $patient.chartNumber ?? "")
            }
            Section(header: Text("Health Data")) {
                TextField("Allergies, comma separated", text: $patient.ramqNumber ?? "")
                NavigationLink(destination: ICDListView()){ Text("Past medical history")}
            }
        }.listStyle(GroupedListStyle())
        .toolbar{
            ToolbarItem(placement:.principal){Text("Patient form")}
            ToolbarItem(placement: .confirmationAction){
                Button("Save", action: Save)
                    .disabled(disableSave)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func Save() -> Void {
        list?.addToPatients(patient)
        patient.saveYourself(in: viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PatientFormView_Previews: PreviewProvider {
    static var previews: some View {
        PatientFormView()
    }
}
