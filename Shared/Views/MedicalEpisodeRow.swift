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
    
    // View UI customization variables
    private var textColor: Color = .black
    private var cardBgColor: Color = .Whitesmoke
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Label(title: {Text(rowModel.patientName).fontWeight(.bold)}, icon: {Image(systemName: "person")}).lineLimit(1)
                Spacer()
                VStack(spacing: 0){
                    Text(rowModel.episode.patient?.ageString ?? "n/a").bold()
                    Text(rowModel.episode.patient?.age != nil ? "years":"age").font(.system(size: 10)).fontWeight(.thin)
                }
            }
            Divider()
            Label(title: {Text(rowModel.diagnosis).font(.footnote).fontWeight(.semibold)}, icon: {Image(systemName: "staroflife")})
            
            Divider()

            
                Label(title: {
                    HStack(alignment: .center){
                        Text("Last seen").foregroundColor(.secondary).font(.caption)
                        Text(rowModel.episode.mostRecentAct?.ramqCode ?? "No act").font(.subheadline)
                    }.lineLimit(1)
                }, icon: {Image(systemName: "calendar")})
            
            Divider()

            HStack{
                Spacer()
                Group{
                    Button(action: rowModel.chooseRoom){Label(rowModel.roomNumber, systemImage: "bed.double")}
                    Label("#00000", systemImage: "folder")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
                Spacer()
                Button(action:{}){Image(systemName: "flag")}
                Button(action: rowModel.addAct){Image(systemName: "plus")}
                Button(action: rowModel.addAct){Image(systemName: "arrowshape.bounce.forward")}
            }
        }.foregroundColor(textColor)
        .padding()
        .background(cardBgColor)
        .cornerRadius(10.0)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)
    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
