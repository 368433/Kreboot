//
//  MedicalEpisodeFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import SwiftUI

import Combine

struct MedicalEpisodeFormView: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var episode: MedicalEpisode
    @ObservedObject var model: MedicalEpisodeFormViewModel
    
    init(episode: MedicalEpisode){
        self.episode = episode
        self.model = MedicalEpisodeFormViewModel(episode: episode)
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
                    DatePicker(selection: $episode.admissionDate ?? Date(), displayedComponents: [.date], label: {Label("Hospitalized", systemImage: "building")})
                    DatePicker(selection: $episode.startDate ?? Date(), displayedComponents: [.date], label: {Label("Start", systemImage: "calendar")})
                    DatePicker(selection: $episode.endDate ?? Date(), displayedComponents: [.date], label: {Label("End", systemImage: "stopwatch")})
                })
                
                Section(header: HStack{
                    Text("Acts")
                }, content: {
                    ForEach(episode.actList()){act in
                        MedicalActRow(act: act)
                    }
                })
            }.navigationBarTitle("Edit episode")
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
