//
//  RoomChangeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-11.
//

import SwiftUI

class LocationChangeViewModel: ObservableObject {
    @Published var currentRoom: String
    @Published var newRoom: String = ""
    private var episode: MedicalEpisode?
    init(episode: MedicalEpisode?){
        self.episode = episode
        self._currentRoom = Published(initialValue: self.episode?.roomLocation ?? "")
    }
    func save(){
        guard let episode = episode else {return}
        episode.roomLocation = newRoom
        episode.saveYourself(in: PersistenceController.shared.container.viewContext)
    }
}

struct RoomChangeView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State private var newRoom = ""
    private var model: LocationChangeViewModel

    init(episode: MedicalEpisode?){self.model = LocationChangeViewModel(episode: episode)}
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action:{
                    model.newRoom = newRoom
                    model.save()
                    self.presentationMode.wrappedValue.dismiss()
                }){Text("Save").fontWeight(.bold)}
            }.padding()
            Text("Update  location").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center).padding(.top)
            HStack {
                VStack{
                    Image(systemName: "bed.double").font(.title)
                    Text(model.currentRoom.isEmpty ? "Current":model.currentRoom).font(.title)
                }.foregroundColor(.secondary)
                Image(systemName: "arrow.right").padding().font(.largeTitle).shadow(color: .gray, radius: 2, x: -2, y: 3)
                VStack{
                    Image(systemName: "bed.double.fill").font(.title)
                    Text("New").font(.title)
                }
            }.padding(.top, 40)
            TextField("New location", text: $newRoom).font(.title3).multilineTextAlignment(.center).padding().background(Color.offWhite.cornerRadius(20)).padding()
            Spacer()
        }
    }
}

struct RoomChangeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomChangeView(episode: nil)
    }
}
