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
            HStack (alignment: .top) {
                HStack {
                    Button(action: {model.activeSheet = .showIdCard; model.selectedEpisode = episode}){Image(systemName: "person.crop.circle.fill").font(.title2)}
                    Text(episode.patient?.name ?? "No name")
                }
                Spacer()
                Button(action: {model.activeSheet = .setDiagnosis; model.selectedEpisode = episode}){ Text(episode.diagnosis?.icd10Description ?? "Diagnosis").font(.footnote)}.buttonStyle(TightOutlineButton())
                Button(action: {model.activeSheet = .addAct; model.selectedEpisode = episode}){Image(systemName: "plus.viewfinder").foregroundColor(.secondary)}.padding(.leading)
            }
            if expandCard {
                HStack{
                    ScrollView{
                        VStack(alignment:.leading){
                            // STRENGHTEN the foreach
                            ForEach(Array(episode.acts as? Set<Act> ?? [])){act in
                                MedicalActRow(act: act).onTapGesture{
                                    model.selectedAct = act
                                    model.activeSheet = .actFormView
                                }
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment:.trailing){
                        Button(action:{}){Text("consulting")}
                        Button(action:{}){Label("Notes", systemImage: "note.text")}.buttonStyle(CapsuleButton())
                        Button(action:{}){Image(systemName: "flag")}
                        Spacer()
                    }.lineLimit(1)
                }.padding(.leading)
            }
            Spacer()
            HStack{
                Group{
                    Button(action: {model.activeSheet = .editRoom; model.selectedEpisode = episode}){Label(episode.roomLocation ?? "room", systemImage: "bed.double")}
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.offWhite)
                        .foregroundColor(.gray)
                        .cornerRadius(20)
                    Label("#00000", systemImage: "folder")
                    Label("Last seen", systemImage: "clock")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
            }
        }
        .padding()
        .frame(maxHeight: expandCard ? 400:90)
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(color: Color.black.opacity(0.3), radius: 5)
        
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
