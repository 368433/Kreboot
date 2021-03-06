//
//  MedicalEpisodeFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import SwiftUI

import Combine

struct MedicalEpisodeFormView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var episode: MedicalEpisode
    @ObservedObject var model: MedicalEpisodeFormViewModel
    @State private var showaddActForm: Bool = false //{
//        didSet{
//            model.setValues()
//        }
//    }
    
    init(episode: MedicalEpisode){
        self.episode = episode
        self.model = MedicalEpisodeFormViewModel(episode: episode)
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Form{
                    Section(header: HStack{
                        Image(systemName: "person.crop.circle")
                        Text("Patient")
                    }, content: {
                        NavigationLink(destination: PatientFormView(patient: model.patient, newEpisode: false), label: {Label(model.patientName, systemImage: "person.crop.rectangle")})
                    })
                    
                    Section(header: HStack{
                        Image(systemName: "staroflife")
                        Text("diagnosis")
                    }, content: {
                        NavigationLink(destination: DiagnosisSearchView(episode: model.episode), label: {Label(model.diagnosis, systemImage: "staroflife.fill")})
                    })
                    
                    Section(header: Text("Episode Details"), content: {
                        NavigationLink(destination: Text("physician"), label: {Label("Consulting physician", systemImage: "figure.wave")})
                        HStack{
                            Label(model.roomLocation ?? "N/A", systemImage: "bed.double.fill")
                            Spacer()
                            TextField("update...", text: $model.newRoom).multilineTextAlignment(.trailing)
                        }
                        //                        NavigationLink(destination: RoomChangeView(episode: episode), label: {Label(model.roomLocation ?? "Not assigned", systemImage: "bed.double.fill")})
                        DatePicker(selection: $model.admissionDate, displayedComponents: [.date], label: {Label("Hospitalized", systemImage: "building")})
                        DatePicker(selection: $model.startDate, displayedComponents: [.date], label: {Label("Start", systemImage: "calendar")})
                        DatePicker(selection: $model.endDate, displayedComponents: [.date], label: {Label("End", systemImage: "stopwatch")})
                    })
                    
                    Section(header: HStack{
                        Text("Acts")
                        Spacer()
                        Button(action: {showaddActForm.toggle()}){Image(systemName: "plus.circle").font(.title2)}
                    }, content: {
                        ForEach(model.acts){act in
                            MedicalActRow(act: act)
                        }.onDelete(perform: model.remove)
                    })
                }
                .sheet(isPresented: $showaddActForm) {
                    ActFormView(for: nil, in: model.episode, isShowing: $showaddActForm)
                }
            }
            .onAppear{model.setValues()}
            .navigationBarTitle("Edit episode")
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button(action: {
                        model.saveForm()
                        self.presentationMode.wrappedValue.dismiss()
                    }){Text("Done")}
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
