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

    init(episode: MedicalEpisode?){self.model = LocationChangeViewModel(episode: episode)}
    
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
            
            Button(action: {self.model.save();presentationMode.wrappedValue.dismiss()}){
                HStack{
                    Spacer(); Text("Save").fontWeight(.bold); Spacer()
                }
            }
        }
        .navigationBarTitle("Update room location")

    }
}

struct RoomChangeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomChangeView(episode: nil)
    }
}
