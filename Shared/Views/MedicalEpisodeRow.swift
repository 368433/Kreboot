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
    private var cardBgColor: Color = Color(UIColor.secondarySystemBackground)
    
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
            }.foregroundColor(.primary)
            Label(title: {
                Text(rowModel.diagnosis)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .lineLimit(3)
            }, icon: {Image(systemName: "staroflife")})
            .foregroundColor(.primary)
            
            Divider()
            HStack{
                HStack{
                    daysCountView(dayCount: rowModel.episode.daysSinceAdmission, dayLabel: "#hosp")
                    Divider().frame(height: 30)
                    daysCountView(dayCount: rowModel.episode.daysSinceSeen, dayLabel: "#seen")
                }.minimumScaleFactor(0.3).foregroundColor(.secondary)
                Spacer()
                Group{
                    Button(action: rowModel.chooseRoom){Label(rowModel.roomNumber, systemImage: "bed.double")}.scaledToFit().minimumScaleFactor(0.3)
                    Button(action: rowModel.flagEpisode){Image(systemName: rowModel.flaggedEpisode ? "flag.fill":"flag").foregroundColor(rowModel.flaggedEpisode ? Color.red:Color.primary)}
                    Button(action: rowModel.addAct){Image(systemName: "plus")}
                    Button(action: {}){Image(systemName: "arrowshape.bounce.forward")}
                }
                .font(.caption)
                .buttonStyle(CapsuleButton(vTightness:.tight, hTightness: .tight, bgColor: Color(UIColor.quaternaryLabel), textColor: Color.primary))
                Spacer()
            }
        }
        .foregroundColor(textColor)
        .padding([.horizontal,.bottom])
        .background(cardBgColor)
        .cornerRadius(10.0)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
        .shadow(color: Color.black.opacity(0.2), radius: 8, y: 8)
        
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
