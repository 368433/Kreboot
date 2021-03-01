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
    
    // View UI customization variables
    private var cardBgColor: Color = Color(UIColor.secondarySystemBackground)
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    var body: some View {
        VStack(alignment: .leading){
            ZStack{
                cardBgColor
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
                }
            }.onTapGesture {
                rowModel.worklistModel.selectedEpisode = rowModel.episode
                rowModel.worklistModel.activeSheet = .medicalEpisodeFormView
            }
            
            Divider()
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
                .transition(.move(edge: .bottom))
            }
            
            if showTriage {
                HStack{
                    Spacer()
                    Group{
                        Button(action:{}){Text("D/C")}
                        Button(action:{}){Text("Transf.")}
                    }.font(.caption2).buttonStyle(CapsuleButton(vTightness:.tight, hTightness: .tight, bgColor: Color.clear, textColor: Color.primary, strokeColor: Color(UIColor.systemGray4)))
                }
                .transition(.move(edge: .bottom))
            }
        }
        .padding([.horizontal,.bottom])
        .background(RoundedRectangle(cornerRadius: Karla.cornerRadius).foregroundColor(cardBgColor).shadow(color: Color.black.opacity(0.2), radius: 8, y: 8))
//        .cornerRadius(10.0)
        .overlay(RoundedRectangle(cornerRadius: Karla.cornerRadius).stroke(Color.gray.opacity(0.3), lineWidth: 1))
        
        
    }
}

struct daysCountView: View {
    var dayCount: Int
    var dayLabel: String
    var body: some View {
        
        VStack(spacing: 0){
            Text("\(dayCount)d").fontWeight(.ultraLight).lineLimit(1)
            Text(dayLabel).font(.caption2).fontWeight(.ultraLight)
        }
    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
