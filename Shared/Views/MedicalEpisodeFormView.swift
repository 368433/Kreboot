//
//  MedicalEpisodeFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import SwiftUI

class MedicalEpisodeFormViewModel: ObservableObject {
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var roomLocation: String?
    @Published var diagnosis: ICD10dx?
    @Published var patient: Patient?
    @Published var list: PatientsList?
    @Published var acts: [Act]?
    @Published var hospitalizedDate: Date?
    @Published var episode: MedicalEpisode?
    
    init(episode: MedicalEpisode?){
        self.episode = episode
        self.patient = episode?.patient
    }
    
    func patientName() -> String {
        return episode?.patient?.wrappedName ?? "None"
    }

}

struct MedicalEpisodeFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    var episode: MedicalEpisode?
    
    @ObservedObject var model: MedicalEpisodeFormViewModel
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: HStack{
                    Image(systemName: "person.crop.circle")
                    Text("Patient")
                }, content: {
                    NavigationLink(model.patient?.wrappedName ?? "ghgh", destination: PatientFormView(patient: model.episode?.patient, to: nil, newEpisode: false))
                })
                
                Section(header: HStack{
                    Image(systemName: "staroflife")
                    Text("diagnosis")
                }, content: {
                    NavigationLink(model.episode?.diagnosis?.wrappedDescription ?? "None", destination: Text("destination"))
                })
                
                Section(header: Text("Episode Details"), content: {
                    DatePicker("Hospitalized", selection: $model.hospitalizedDate ?? Date(), displayedComponents: [.date])
                    NavigationLink(destination: Text("physician"), label: {Label("Consulting physician", systemImage: "figure.wave")})
                    NavigationLink(destination: RoomChangeView(episode: model.episode), label: {Label("Current room", systemImage: "bed.double.fill")})
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
                    Text(model.patient?.wrappedName ?? "error")
                    Text("sefasdasd")
                    Text("sefasdasd")
                    Text("sefasdasd")
                    Text("sefasdasd")
                })
                
                
            }.navigationBarTitle("\(model.episode?.patient?.name ?? "")")
        }
    }
}

//struct MedicalEpisodeFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeFormView()
//    }
//}
