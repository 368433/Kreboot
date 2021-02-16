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
    
    private var maxHeight: CGFloat { return 350 }
    private var minHeight: CGFloat { return 100 }
    private var expandCard: Bool {return showFullCard && episode.acts?.count != 0}
    private var couldExpand: Bool {return episode.acts?.count != 0}
    private var noActs: Bool {return showFullCard && episode.acts.isNull}
    
    
    var body: some View {
        VStack{
            HStack (alignment: .center) {
                Button(action: {model.activeSheet = .showIdCard; model.selectedEpisode = episode}){Image(systemName: "person.crop.circle.fill").font(.title2)}
                VStack (alignment: .leading){
                    Text(episode.patient?.name ?? "No name").fontWeight(.bold)
                    Button(action: {model.activeSheet = .setDiagnosis; model.selectedEpisode = episode}){ Text(episode.diagnosis?.icd10Description ?? "Diagnosis").font(.footnote)}
                }
                Spacer()
                Button(action: {model.activeSheet = .addAct; model.selectedEpisode = episode}){Image(systemName: "plus")}
                
            }.lineLimit(1)//.buttonStyle(PlainButtonStyle())

            Divider()
            
            if expandCard {
                ActListView(model: ActListViewModel(episode: episode), selectedAct: $model.selectedAct, activeSheet: $model.activeSheet)
                
                HStack(alignment:.bottom){
                    Button(action:{}){Text("Consulting MD")}; Spacer()
                    Button(action:{}){Label("Notes", systemImage: "note.text")}; Spacer()
                    Button(action:{}){Image(systemName: "flag")}
                }.font(.subheadline).lineLimit(1)
                
                Divider()
            }

            HStack{
                Group{
                    Button(action: {model.activeSheet = .editRoom; model.selectedEpisode = episode}){Label(episode.roomLocation ?? "room", systemImage: "bed.double")}
                    Label("#00000", systemImage: "folder")
                    Label("Last seen", systemImage: "clock")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
            }
        }
        .padding()
        .frame(maxHeight: expandCard ? maxHeight:minHeight)
        .background(Color.Aliceblue)
        .cornerRadius(10.0)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)

        .onTapGesture {
            model.selectedEpisode = episode
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
