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
    
    //State variables
    @State private var showFullCard: Bool = false
    @State private var flagged: Bool = false
    
    // View UI customization variables
    private var textColor: Color = .black
    private var cardBgColor: Color = .Whitesmoke
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    var body: some View {
//        GeometryReader { geometry in
            VStack(alignment: .leading){
                Text("#00000").foregroundColor(.secondary).font(.caption).lineLimit(1).padding(.top,8)
                HStack{
                    Label(title: {Text(rowModel.patientName).fontWeight(.bold)}, icon: {Image(systemName: "person")}).lineLimit(1)
                    Spacer()
                    VStack(spacing: 0){
                        Text(rowModel.episode.patient?.ageString ?? "n/a").bold()
                        Text(rowModel.episode.patient?.age != nil ? "years":"age").font(.system(size: 10)).fontWeight(.thin)
                    }
                }

                HStack(alignment:.top){
                    Label(title: {Text(rowModel.diagnosis).font(.footnote).fontWeight(.semibold)}, icon: {Image(systemName: "staroflife")})
                    Spacer()
                    VStack{
                        Text("test this as a place pushing").fontWeight(.light)
                    }
                    
                }
                Divider()
                HStack{
                    Spacer()
                    Button(action: rowModel.chooseRoom){Label(rowModel.roomNumber, systemImage: "bed.double")}
                    Button(action:{}){Image(systemName: "flag")}
                    Button(action: rowModel.addAct){Image(systemName: "plus")}
                    Button(action: rowModel.addAct){Image(systemName: "arrowshape.bounce.forward")}
                    Spacer()
                }.font(.caption).buttonStyle(CapsuleButton(vTightness:.tight, hTightness: .tight, bgColor: .white, textColor: .black)).shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)
            }.foregroundColor(textColor)
            .padding([.horizontal,.bottom])
            .background(cardBgColor)
            .cornerRadius(10.0)
            .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)
//        }
        
    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
