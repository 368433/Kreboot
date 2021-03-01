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
        self.model = LocationChangeViewModel(episode: episode)
    }
    
    var body: some View {
        Form {
            HStack{
                Text("Last location")
                Spacer()
                Text(model.currentRoom)
            }
            HStack{
                Text("New location")
                Spacer()
                TextField("Enter new location", text: $model.newRoom).multilineTextAlignment(.trailing)
            }
            Button(action: {self.model.save(); self.presentationMode.wrappedValue.dismiss()}){
                HStack{
                    Spacer(); Text("Save").fontWeight(.bold); Spacer()
                }
            }
        }
        .navigationBarTitle("Update room location")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewRoomView: View {
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var model: WorklistViewModel
    
    init(worklistModel: WorklistViewModel){
        self.model = worklistModel
    }
    
    var body: some View {
        VStack{
            TextField("Last location \(model.selectedEpisode?.roomLocation ?? "n/a")", text: $model.newRoom).multilineTextAlignment(.center)
            Button(action: {model.saveRoom()}){Text("Done")}
        }.padding()
        .background(RoundedRectangle(cornerRadius: Karla.cornerRadius)
                        .foregroundColor(Color(UIColor.tertiarySystemBackground))
                        .shadow(color: Color.gray.opacity(0.6), radius: 10, y: 10))
    }
}

struct RoomChangeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomChangeView(worklistModel: WorklistViewModel(patientsList: PersistenceController.singleList), episode: PersistenceController.singleMedicalEpisode)
    }
}
