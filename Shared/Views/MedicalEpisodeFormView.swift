//
//  MedicalEpisodeFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import SwiftUI

import Combine
class MedicalEpisodeFormViewModel: ObservableObject {
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var roomLocation: String?
    @Published var diagnosis: ICD10dx?
    @Published var list: PatientsList?
    @Published var acts: [Act]?
    @Published var hospitalizedDate: Date?
    @Published var patientName: String = ""
    
    @ObservedObject var episode: MedicalEpisode
    @Published var patient: Patient
    private var subscriptions = Set<AnyCancellable>()

    init(episode: MedicalEpisode?){
        self.episode = episode ?? MedicalEpisode(context: PersistenceController.shared.container.viewContext)
        self.patient = episode?.patient ?? Patient(context: PersistenceController.shared.container.viewContext)
    }

}

struct MedicalEpisodeFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var model: MedicalEpisodeFormViewModel
//    @ObservedObject var episode: MedicalEpisode
//    @ObservedObject var patient: Patient
    
    init(episode: MedicalEpisode?){
        self.model = MedicalEpisodeFormViewModel(episode: episode)
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: HStack{
                    Image(systemName: "person.crop.circle")
                    Text("Patient")
                }, content: {
                    NavigationLink(destination: PatientFormView(patient: model.patient, newEpisode: false), label: {Label(model.patient.wrappedName, systemImage: "person.crop.rectangle")})
                })
                
                Section(header: HStack{
                    Image(systemName: "staroflife")
                    Text("diagnosis")
                }, content: {
                    NavigationLink(destination: DiagnosisSearchView(episode: model.episode), label: {Label(model.episode.diagnosis?.wrappedDescription ?? "None", systemImage: "staroflife.fill")})
                })
                
                Section(header: Text("Episode Details"), content: {
                    DatePicker(selection: $model.hospitalizedDate ?? Date(), displayedComponents: [.date], label: {Label("Hospitalized", systemImage: "building")})
                    NavigationLink(destination: Text("physician"), label: {Label("Consulting physician", systemImage: "figure.wave")})
                    NavigationLink(destination: RoomChangeView(episode: model.episode), label: {Label(model.episode.roomLocation ?? "Not assigned", systemImage: "bed.double.fill")})
                    DisclosureGroup(content: {
                        DatePicker("Start", selection: $model.startDate ?? Date())
                        DatePicker("End", selection: $model.endDate ?? Date())
                    }, label: {
                        Label("More details", systemImage: "ellipsis.circle")
                    })
                })
                
                Section(header: HStack{
                    Text("Acts")
                }, content: {
                    ForEach(model.episode.actList()){act in
                        MedicalActRow(act: act)
                    }
                })
                
                
            }.navigationBarTitle("\(model.episode.patient?.name ?? "")")
        }
    }
}

//struct MedicalEpisodeFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeFormView()
//    }
//}
