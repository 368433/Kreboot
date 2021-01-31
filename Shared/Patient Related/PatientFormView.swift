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
    
    var patient: Patient?
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
        self.patient = patient
        self._title = State(initialValue: patient?.name ?? "Unnamed")
        self._name = State(initialValue: patient?.name ?? "")
        self._ramq = State(initialValue: patient?.ramqNumber ?? "")
        self._chartNumber = State(initialValue: patient?.chartNumber ?? "")
        self._postalCode = State(initialValue: patient?.postalCode ?? "")
        self._dateOfBirth = State(initialValue: patient?.dateOfBirth ?? Date())
    }
    
    var body: some View {
        List {
            Section(header: Text("Personnal data")) {
                TextField("Name", text: $name)
                    .labeledTF(label: "Name", isEmpty: name == "")
                TextField("PostalCode", text: $postalCode)
                    .labeledTF(label: "Postal Code", isEmpty: postalCode == "")
                DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
            }
            Section(header: Text("Healthcare system Data")) {
                TextField("RAMQ", text: $ramq)
                    .labeledTF(label: "RAMQ", isEmpty: ramq == "")
                TextField("Chart number", text: $chartNumber)
                    .labeledTF(label: "Chart Number", isEmpty: chartNumber == "")
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
        // TODO Add message to confirm overwriting changes
        guard name != "" else { return }
        
        if let patient = patient {
            savePatient(patient)
        }else {
            let newPatient = Patient(context: viewContext)
            savePatient(newPatient)
        }
    }
    
    private func savePatient( _ patient: Patient){
        patient.name = self.name
        patient.chartNumber = self.chartNumber
        patient.ramqNumber = self.ramq
        patient.postalCode = self.postalCode
        patient.dateOfBirth = self.dateOfBirth
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}

struct PatientFormView_Previews: PreviewProvider {
    static var previews: some View {
        PatientFormView()
    }
}
