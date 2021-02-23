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
        VStack(alignment: .leading){
            Text("#00000").foregroundColor(.secondary).font(.caption).lineLimit(1).padding(.top,8)
            HStack{
                Label(title: {Text(rowModel.patientName).fontWeight(.bold)}, icon: {Image(systemName: "person")}).lineLimit(1)
                Spacer()
                VStack(spacing: 0){
                    Text(rowModel.episode.patient?.ageString ?? "n/a").bold()
                    Text("yrs").font(.system(size: 10)).fontWeight(.thin)
                }
            }
            
            Label(title: {Text(rowModel.diagnosis).font(.footnote).fontWeight(.semibold)}, icon: {Image(systemName: "staroflife")})
            
            Divider()
            HStack{
                HStack{
                    daysCountView(dayCount: 20, dayLabel: "#hosp")
                    Divider()
                    daysCountView(dayCount: 2, dayLabel: "#seen")
                }
                Spacer()
                Group{
                    Button(action: rowModel.chooseRoom){Label(rowModel.roomNumber, systemImage: "bed.double")}.scaledToFit().minimumScaleFactor(0.3)
                    Button(action:{}){Image(systemName: "flag")}
                    Button(action: rowModel.addAct){Image(systemName: "plus")}
                    Button(action: rowModel.addAct){Image(systemName: "arrowshape.bounce.forward")}
                }
                .font(.caption)
                .buttonStyle(CapsuleButton(vTightness:.tight, hTightness: .tight, bgColor: .white, textColor: .black)).shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)
                Spacer()
            }
        }.foregroundColor(textColor)
        .padding([.horizontal,.bottom])
        .background(cardBgColor)
        .cornerRadius(10.0)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
        .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)
        
    }
}

struct daysCountView: View {
    var dayCount: Int
    var dayLabel: String
    var body: some View {
        
        VStack(spacing: 0){
            Text("\(dayCount)d").fontWeight(.ultraLight).lineLimit(1)
            Text(dayLabel).font(.caption2).fontWeight(.ultraLight).minimumScaleFactor(0.2)
        }
    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
