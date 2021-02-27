//
//  RoomChangeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-11.
//

import SwiftUI



struct RoomChangeView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var model: LocationChangeViewModel
    
    init(worklistModel: WorklistViewModel? = nil, episode: MedicalEpisode){
        self.model = LocationChangeViewModel(episode: episode, wlModel: worklistModel)
    }
    
    var body: some View {
        Form {
            HStack{
                Text("Current location")
                Spacer()
                Text(model.currentRoom)
            }
            HStack{
                Text("New location")
                Spacer()
                TextField("Enter new location", text: $model.newRoom)
            }
            Button(action: {self.model.save()}){
                HStack{
                    Spacer(); Text("Save").fontWeight(.bold); Spacer()
                }
            }
        }.padding()
        .background(Color.white.shadow(color: Color.gray.opacity(0.6), radius: 10, y: 10))
        .padding(.horizontal)
        .navigationBarTitle("Update room location")
    }
}

struct NewRoomView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var model: LocationChangeViewModel
    
    init(worklistModel: WorklistViewModel, episode: MedicalEpisode){
        self.model = LocationChangeViewModel(episode: episode, wlModel: worklistModel)
    }
    
    var body: some View {
        VStack{
            TextField("Room or location", text: $model.currentRoom)
            Button(action: {}){Text("Update")}
        }.padding()
        .background(Color.white.shadow(color: Color.gray.opacity(0.6), radius: 10, y: 10))
        .padding(.horizontal)
    }
}

struct RoomChangeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomChangeView(worklistModel: WorklistViewModel(patientsList: PersistenceController.singleList), episode: PersistenceController.singleMedicalEpisode)
    }
}
