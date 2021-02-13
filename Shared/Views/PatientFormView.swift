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
    
    @ObservedObject private var model: PatientFormViewModel
    
    init(patient: Patient? = nil, to list: PatientsList? = nil){
        self.model = PatientFormViewModel(list: list, patient: patient)
    }
    
    @State private var comments: String = ""
    
    var disableSave: Bool {
        return model.disableForm
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
                TextField("Name", text: $model.name)
                TextField("PostalCode", text: $model.postalCode)
                Button(action: {}){
                    HStack{
                        Text("Card photo")
                        Spacer()
                        Image(systemName: "person.crop.rectangle")
                    }
                }
                DatePicker("Date of Birth", selection: $model.dateOfBirth, displayedComponents: .date)
            }
            Section(header: Text("Healthcare system Data")) {
                TextField("RAMQ", text: $model.ramqNumber)
                TextField("Chart number", text: $model.chartNumber)
            }
            Section(header: Text("Allergies")) {
                TextField("Allergies, comma separated", text: $model.ramqNumber)
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
            ToolbarItem{
                Button("Save", action: save)
                    .disabled(false)

            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func save(){
        model.save()
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PatientFormView_Previews: PreviewProvider {
    static var previews: some View {
        PatientFormView()
    }
}
