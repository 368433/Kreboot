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
    
    @ObservedObject var patientt: Patient
    var disableSave: Bool {
        return name == ""
    }
    
    @State var title: String = ""
    @State var name: String = ""
    @State var ramq: String = ""
    @State var chartNumber: String = ""
    @State var postalCode: String = ""
    @State var dateOfBirth: Date = Date()
    
    init(patient: Patient? = nil){
        self.patientt = patient ?? Patient()
        
        self._title = State(initialValue: patient?.name ?? "Unnamed")
        self._name = State(initialValue: patient?.name ?? "")
        self._ramq = State(initialValue: patient?.ramqNumber ?? "")
        self._chartNumber = State(initialValue: patient?.chartNumber ?? "")
        self._postalCode = State(initialValue: patient?.postalCode ?? "")
        self._dateOfBirth = State(initialValue: patient?.dateOfBirth ?? Date())
    }
    
    var body: some View {
//        NavigationView{
            List {
                Section(
                    header:
                        HStack{
                            Text("Personnal data")
                            Spacer()
                            Button(action: {}){Image(systemName: "doc.text.viewfinder")}.buttonStyle(CircularButton())
                        }) {
                    TextField("Name", text: $patientt.name ?? "")
                        .labeledTF(label: "Name", isEmpty: name == "")
                    TextField("PostalCode", text: $postalCode)
                        .labeledTF(label: "Postal Code", isEmpty: postalCode == "")
                    HStack{
                        Text("Card photo")
                        Spacer()
                        Image(systemName: "person.crop.rectangle")
                    }
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                }
                Section(header: Text("Healthcare system Data")) {
                    TextField("RAMQ", text: $ramq)
                        .labeledTF(label: "RAMQ", isEmpty: ramq == "")
                    TextField("Chart number", text: $chartNumber)
                        .labeledTF(label: "Chart Number", isEmpty: chartNumber == "")
                }
                Section(header: Text("Health Data")) {
                    TextField("Allergies, comma separated", text: $ramq)
                    NavigationLink(destination: Text("Past medical history")){ Text("Past medical history")}
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
//        }
    }
    
    private func Save() -> Void {
        // TODO Add message to confirm overwriting changes
        guard name != "" else { return }
        viewContext.insert(patientt)
        let patientToSave = Patient(context: viewContext)
        patientToSave.name = self.name
        patientToSave.chartNumber = self.chartNumber
        patientToSave.ramqNumber = self.ramq
        patientToSave.postalCode = self.postalCode
        patientToSave.dateOfBirth = self.dateOfBirth
        patientToSave.saveYourself(in: viewContext)
    }
}

struct PatientFormView_Previews: PreviewProvider {
    static var previews: some View {
        PatientFormView()
    }
}
