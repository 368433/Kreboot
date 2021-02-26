//
//  ActFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-12.
//

import SwiftUI

class AddActViewModel: ObservableObject {
    @Published var searchActText: String = ""
    @Published var actCode: String = ""
    @Published var actDate: Date = Date()
    @Published var historyNote: String = ""
    @Published var physicalExamNote = ""
    @Published var consultingPhysician = ""
    private var episode: MedicalEpisode?
    private var act: Act?
    
    init(act: Act?, episode: MedicalEpisode?){
        self.episode = episode
        self.act = act
        
        self._actCode = Published(initialValue: self.act?.ramqCode ?? "")
        self._actDate = Published(initialValue: self.act?.timestamp ?? Date())
    }
    
    func saveAct(){
        let context = PersistenceController.shared.container.viewContext
        let actToSave = act ?? Act(context: context)
        actToSave.ramqCode = self.actCode
        actToSave.timestamp = self.actDate
        if let episode = episode {
            actToSave.medicalEpisode = episode
        }
        actToSave.saveYourself(in: context)
    }
}


struct ActFormView: View {
//    @State private var searchActText: String = ""
//    @State private var actDate: Date = Date()
//    @State private var historyNote: String = ""
//    @State private var physicalExamNote = ""
//    @State private var consultingPhysician = ""
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var model: AddActViewModel
    
    init(for act: Act?, in episode: MedicalEpisode?){
        self.model = AddActViewModel(act: act, episode: episode)
    }
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0){
            HStack{
                Text("Act Form").font(.largeTitle).fontWeight(.heavy)
                Spacer()
                Button(action:{
                    model.saveAct()
                    self.presentationMode.wrappedValue.dismiss()
                }){Text("Save").fontWeight(.bold)}.buttonStyle(PlainButtonStyle())
            }.padding([.top, .horizontal])
            Form{
                Section(header: Text("ACT")) {
                    TextField("Search code", text: $model.actCode)
                    if !model.searchActText.isEmpty {
                        Text("test")
                    }
                    DatePicker("Date", selection: $model.actDate, displayedComponents: [.date, .hourAndMinute])
                }
                
                if !model.searchActText.isEmpty {
                    Section(header: Text("Consulting physician")) {
                        TextField("Search physician db", text: $model.historyNote)
                        TextField("Manual entry", text: $model.consultingPhysician)
                        Text("Physician name")
                    }
                }
                DisclosureGroup("Note") {
                    Section(header: Text("History")) {
                        TextField("History", text: $model.historyNote).frame(height: 100)
                    }
                    Section(header: Text("Physical Exam")) {
                        TextField("Physical Examination", text: $model.physicalExamNote).frame(height: 70)
                    }
                    Section(header: Text("Laboratory")) {
                        TextField("Laboratory", text: $model.physicalExamNote).frame(height: 70)
                    }
                    Section(header: Text("Summary and Conclusion")) {
                        TextField("Summary and Conclusion", text: $model.physicalExamNote).frame(height: 100)
                    }
                }
            }//.padding(.top)
        }
    }
}

struct AddActView_Previews: PreviewProvider {
    static var previews: some View {
        ActFormView(for: nil, in: nil)
    }
}
