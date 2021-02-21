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
//    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var episode: MedicalEpisode

    
    init(episode: MedicalEpisode){
        self.episode = episode
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: HStack{
                    Image(systemName: "person.crop.circle")
                    Text("Patient")
                }, content: {
                    NavigationLink(destination: PatientFormView(patient: episode.patient, newEpisode: false), label: {Label(episode.getPatientName(), systemImage: "person.crop.rectangle")})
                })
                
                Section(header: HStack{
                    Image(systemName: "staroflife")
                    Text("diagnosis")
                }, content: {
                    NavigationLink(destination: DiagnosisSearchView(episode: episode), label: {Label(episode.diagnosis?.wrappedDescription ?? "None", systemImage: "staroflife.fill")})
                })
                
                Section(header: Text("Episode Details"), content: {
                    NavigationLink(destination: Text("physician"), label: {Label("Consulting physician", systemImage: "figure.wave")})
                    NavigationLink(destination: RoomChangeView(episode: episode), label: {Label(episode.roomLocation ?? "Not assigned", systemImage: "bed.double.fill")})
                    DisclosureGroup(content: {
                        DatePicker(selection: $episode.startDate ?? Date(), displayedComponents: [.date], label: {Label("Hospitalized", systemImage: "building")})
                        DatePicker("Start", selection: $episode.startDate ?? Date())
                        DatePicker("End", selection: $episode.endDate ?? Date())
                    }, label: {
                        Label("More details", systemImage: "ellipsis.circle")
                    })
                })
                
                Section(header: HStack{
                    Text("Acts")
                }, content: {
                    ForEach(episode.actList()){act in
                        MedicalActRow(act: act)
                    }
                })
            }.navigationBarTitle("Episode: \(episode.patient?.name ?? "")")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}){Text("Done")}
                }
            }
        }
    }
}

//struct MedicalEpisodeFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeFormView()
//    }
//}
