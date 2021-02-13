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
    var list: PatientsList? = nil
    @State private var comments: String = ""
    
    var disableSave: Bool {
        return patient.name?.isEmpty ?? true
    }
    
    init(patient: Patient? = nil, to list: PatientsList? = nil){
        self.patient = patient ?? Patient(context: PersistenceController.shared.container.viewContext)
        self.list = list
    }
    
    var body: some View {
        Form {
            Section( header: VStack(alignment: .leading, spacing: 0){
                HStack {
                    Spacer()
                    Button(action: {}){Image(systemName: "doc.text.viewfinder")}.buttonStyle(CircularButton())//.padding(.top)
                }
                Text("Personnal data")
            }) {
                TextField("Name", text: $patient.name ?? "")
                TextField("PostalCode", text: $patient.postalCode ?? "")
                Button(action: {}){
                    HStack{
                        Text("Card photo")
                        Spacer()
                        Image(systemName: "person.crop.rectangle")
                    }
                }
                DatePicker("Date of Birth", selection: $patient.dateOfBirth ?? Date(), displayedComponents: .date)
            }
            Section(header: Text("Healthcare system Data")) {
                TextField("RAMQ", text: $patient.ramqNumber ?? "")
                TextField("Chart number", text: $patient.chartNumber ?? "")
            }
            Section(header: Text("Allergies")) {
                TextField("Allergies, comma separated", text: $patient.ramqNumber ?? "")
                Text("Frequency List:").font(.subheadline).fontWeight(.light).foregroundColor(.secondary)
                
            }
            Section(header: Text("Past Medical History")) {
                NavigationLink(destination: ICDListView()){
                    HStack{
                        Text("Add ICD dx")
                        Spacer()
                        Image(systemName: "plus.magnifyingglass")
                    }
                }
                Text("Frequency List:").font(.subheadline).fontWeight(.light).foregroundColor(.secondary)
                DisclosureGroup("View Past Medical History") {
                    List{
                        Text("First dx")
                        Text("Second dx")
                        Text("Third dx")
                    }
                }
            }
            
            Section(header: Text("Episodes of care")){
                DisclosureGroup("View encounters") {
                    EmptyView()
                }
            }
            
            Section(header: Text("Comments")){
                TextField("", text: $comments).frame(height: 100)
            }
        }
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
