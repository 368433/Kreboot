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
    @State private var showRoomEdit: Bool = false
    @State private var showTriage: Bool = false
    @State var newRoom: String = ""
    
    //Gesture variables
    @State private var offset = CGSize.zero
    var swipeGesture: some Gesture{
        DragGesture()
            .onChanged{value in
                if value.translation.width > 0 { offset = value.translation}
            }
            .onEnded{value in
                withAnimation{
                    offset = CGSize.zero
                }
            }
    }
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            
            EpisodeCardTopSection(
                cardBgColor: Karla.episodeCardBgColor,
                chartNumber: rowModel.chartNumber,
                patientName: rowModel.patientName,
                age: rowModel.patientAge,
                diagnosis: rowModel.diagnosis)
            .onTapGesture {
                rowModel.worklistModel.selectedEpisode = rowModel.episode
                rowModel.worklistModel.activeSheet = .medicalEpisodeFormView
            }
            
            Divider()
            ZStack{
                Karla.episodeCardBgColor
                HStack{
                    // Bottom hospit and seen days indicators
                    HStack{
                        daysCountView(dayCount: rowModel.episode.daysSinceAdmission, dayLabel: "#hosp")
                        Divider().frame(height: 30)
                        daysCountView(dayCount: rowModel.episode.daysSinceSeen, dayLabel: "#seen")
                    }.foregroundColor(.secondary)
                    
                    Spacer()
                    
                    // Bottom buttons
                    Group{
                        Button(action: {showRoomEdit.toggle();showTriage = false}){Label(rowModel.roomNumber, systemImage: "bed.double")}
                        Button(action: rowModel.flagEpisode){Image(systemName: rowModel.flaggedEpisode ? "flag.fill":"flag").foregroundColor(rowModel.flaggedEpisode ? Color.red:Color.primary)}
                        Button(action: rowModel.addAct){Image(systemName: "plus")}
                        Button(action: {showRoomEdit=false;showTriage.toggle()}){Image(systemName: "arrowshape.bounce.forward")}
                    }
                    .font(.footnote)
                    .buttonStyle(CapsuleButton(vTightness:.tight, hTightness: .tight, bgColor: Color(UIColor.quaternaryLabel), textColor: Color.primary))
                }
            }

            
            if showRoomEdit {
                HStack{
                    Spacer()
                    TextField("Update room...", text: $newRoom)
                        .padding(4)
                        .frame(maxWidth: 120)
                        .multilineTextAlignment(.center)
                        .overlay(RoundedRectangle(cornerRadius: 30).stroke(Color(UIColor.systemGray3)))
                    Button(action:{rowModel.saveRoom(newRoom);showRoomEdit.toggle()}){Text("Save")}
                    Spacer()
                }
                .font(.footnote)
                .transition(.scale)
            }
            
            if showTriage {
                HStack{
                    Spacer()
                    Group{
                        Button(action:{}){Text("D/C")}
                        Button(action:{}){Text("Transf.")}
                    }.font(.caption2).buttonStyle(CapsuleButton(vTightness:.tight, hTightness: .tight, bgColor: Color.clear, textColor: Color.primary, strokeColor: Color(UIColor.systemGray4)))
                }
                .transition(.move(edge: .top))
            }
        }
        .padding([.horizontal,.bottom])
        .background(RoundedRectangle(cornerRadius: Karla.cornerRadius).foregroundColor(Karla.episodeCardBgColor).shadow(color: Color.black.opacity(0.2), radius: 8, y: 8))
        .overlay(RoundedRectangle(cornerRadius: Karla.cornerRadius).stroke(Color.gray.opacity(0.3), lineWidth: 1))
        .offset(x: offset.width, y: 0) //for swipe gesture response
        .gesture(swipeGesture)
        .animation(.default)
    }
}

struct EpisodeCardTopSection: View {
    var cardBgColor: Color
    var chartNumber: String
    var patientName: String
    var age: String
    var diagnosis: String
    
    var body: some View {
        ZStack{
            cardBgColor
            VStack(alignment: .leading){
                Text(chartNumber).foregroundColor(.secondary).font(.caption).lineLimit(1).padding(.top,8)
                HStack{
                    Label(title: {Text(patientName).fontWeight(.bold)}, icon: {Image(systemName: "person")}).lineLimit(1)
                    Spacer()
                    VStack(spacing: 0){
                        Text(age).bold()
                        Text("yrs").font(.system(size: 10)).fontWeight(.thin)
                    }
                }.foregroundColor(.primary)
                Label(title: {
                    Text(diagnosis)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(3)
                }, icon: {Image(systemName: "staroflife")})
                .foregroundColor(.primary)
            }
        }
    }
}
struct daysCountView: View {
    var dayCount: Int
    var dayLabel: String
    var body: some View {
        
        VStack(spacing: 0){
            Text("\(dayCount)d").fontWeight(.light).lineLimit(1)
            Text(dayLabel).font(.caption2).fontWeight(.light)
        }.foregroundColor(Color(UIColor.lightGray))
    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
