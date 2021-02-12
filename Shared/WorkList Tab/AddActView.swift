//
//  AddActView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-12.
//

import SwiftUI

struct AddActView: View {
    @State private var searchActText: String = ""
    @State private var actDate: Date = Date()
    @State private var historyNote: String = ""
    @State private var physicalExamNote = ""
    @State private var consultingPhysician = ""
    
    var body: some View {
        Form{
            Section(header: Text("ACT")) {
                TextField("Search code", text: $searchActText)
                if !searchActText.isEmpty {
                    Text("test")
                }
                DatePicker("Performed", selection: $actDate, displayedComponents: [.date, .hourAndMinute])
            }
            
            if !searchActText.isEmpty {
                Section(header: Text("Consulting physician")) {
                    TextField("Search physician db", text: $historyNote)
                    TextField("Manual entry", text: $consultingPhysician)
                    Text("Physician name")
                }
            }
            
            DisclosureGroup("Note") {
                Section(header: Text("History")) {
                    TextField("History", text: $historyNote).frame(height: 100)
                }
                Section(header: Text("Physical Exam")) {
                    TextField("Physical Examination", text: $physicalExamNote).frame(height: 70)
                }
                Section(header: Text("Laboratory")) {
                    TextField("Laboratory", text: $physicalExamNote).frame(height: 70)
                }
                Section(header: Text("Summary and Conclusion")) {
                    TextField("Summary and Conclusion", text: $physicalExamNote).frame(height: 100)
                }
            }
            
        }
    }
}

struct AddActView_Previews: PreviewProvider {
    static var previews: some View {
        AddActView()
    }
}
