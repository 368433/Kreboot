//
//  MedicalEpisodeRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-13.
//

import SwiftUI

struct MedicalEpisodeRow: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var episode: MedicalEpisode
    @ObservedObject var model: WorklistViewModel
    
    @State private var showFullCard: Bool = false
    private var expandCard: Bool {return showFullCard && episode.acts?.count != 0}
    private var couldExpand: Bool {return episode.acts?.count != 0}
    
    var body: some View {
        VStack{
            HStack (alignment: .center) {
                HStack {
                    Button(action: {model.activeSheet = .showIdCard; model.selectedEpisode = episode}){Image(systemName: "person.crop.circle.fill").font(.title2)}
                    Text(episode.patient?.name ?? "No name").fontWeight(.bold)
                }
                Spacer()
                Button(action: {model.activeSheet = .setDiagnosis; model.selectedEpisode = episode}){ Text(episode.diagnosis?.icd10Description ?? "Diagnosis").fontWeight(.bold)}//.buttonStyle(TightOutlineButton())
                Button(action: {model.activeSheet = .addAct; model.selectedEpisode = episode}){Image(systemName: "plus")}.padding(.leading)
            }
            Divider()
            if expandCard {
                VStack (alignment: .leading){
                    Text("Act list").font(.subheadline).fontWeight(.bold).padding(.trailing)
                    ScrollView{
                        VStack(alignment:.leading, spacing: 5){
                            // STRENGHTEN the foreach
                            ForEach(Array(episode.acts as? Set<Act> ?? [])){act in
                                MedicalActRow(act: act).onTapGesture{
                                    model.selectedAct = act
                                    model.activeSheet = .actFormView
                                }
                            }
                        }
                    }.padding([.leading, .bottom])
                    
                    HStack(alignment:.bottom){
                        Button(action:{}){Text("Consulting MD")}; Spacer()
                        Button(action:{}){Label("Notes", systemImage: "note.text")}; Spacer()
                        Button(action:{}){Image(systemName: "flag")}
                    }.font(.subheadline).lineLimit(1)
                    Divider()
                }
            }
            Spacer()
            HStack{
                Group{
                    Button(action: {model.activeSheet = .editRoom; model.selectedEpisode = episode}){Label(episode.roomLocation ?? "room", systemImage: "bed.double")}
                    Label("#00000", systemImage: "folder")
                    Label("Last seen", systemImage: "clock")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
            }
        }
        .padding()
        .frame(maxHeight: expandCard ? 300:90)
        .background(Color.white)
        .cornerRadius(10.0)
//        .shadow(color: Color.black.opacity(0.3), radius: 5)
        
        .onTapGesture {
            if couldExpand {
                withAnimation{
                    showFullCard.toggle()
                    model.hideActionButton = expandCard
                }
            }
        }
    }
}

struct MedicalEpisodeRow_Previews: PreviewProvider {
    static var previews: some View {
        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, model: WorklistViewModel())
    }
}
