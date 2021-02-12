//
//  RoomChangeView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-11.
//

import SwiftUI

struct RoomChangeView: View {
    @State private var currentRoom = ""
    @State private var newRoom = ""
    
    var body: some View {
        VStack {
            Text("Update  location").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center).padding(.top, 200)
            HStack {
                VStack{
                    Image(systemName: "bed.double").font(.title)
                    Text("Current").font(.title)
                }.foregroundColor(.secondary)
                Image(systemName: "arrow.right").padding().font(.largeTitle).shadow(color: .gray, radius: 2, x: -2, y: 3)
                VStack{
                    Image(systemName: "bed.double.fill").font(.title)
                    Text("New").font(.title)
                }
            }.padding(.top, 40)
            TextField("New location", text: $newRoom).multilineTextAlignment(.center).padding().background(Color.offWhite.cornerRadius(20)).padding()
            Spacer()
        }
    }
}

struct RoomChangeView_Previews: PreviewProvider {
    static var previews: some View {
        RoomChangeView()
    }
}
