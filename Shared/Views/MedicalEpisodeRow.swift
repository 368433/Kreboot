//
//  MedicalEpisodeRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-13.
//

import SwiftUI

struct MedicalEpisodeRow: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var rowModel: MedicalEpisodeRowViewModel
    @State private var showFullCard: Bool = false
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            Group{
                Text(rowModel.patientName).fontWeight(.bold)
                Label(title: {Text(rowModel.diagnosis).font(.footnote).fontWeight(.semibold)}, icon: {Image(systemName: "staroflife")})
            }.lineLimit(1)
            
            Divider()
            
            HStack(alignment: .center){
                Text("Last seen").foregroundColor(.secondary).font(.caption)
                Text("asdfasdfasdfasdasdfa").font(.subheadline)
            }.lineLimit(1)
            
            Divider()

            HStack{
                Group{
                    Label(rowModel.roomNumber, systemImage: "bed.double")
                    Label("#00000", systemImage: "folder")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
                Spacer()
                Button(action:{}){Image(systemName: "flag")}
                Button(action: rowModel.addAct){Image(systemName: "plus")}
            }
        }
        .padding()
        .background(Color.Aliceblue)
        .cornerRadius(10.0)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)

    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
