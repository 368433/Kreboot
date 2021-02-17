//
//  MedicalEpisodeRow.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-13.
//

import SwiftUI

class MedicalEpisodeRowViewModel: ObservableObject {
    @Published var episode: MedicalEpisode
    @Published var cardHeight: CGFloat = 350
    
    @Published var diagnosis: String
    @Published var patientName: String
    @Published var roomNumber: String
    @Published var expandCard: Bool = false {
        didSet{
            withAnimation{
                cardHeight = expandCard ? 350:100
            }
        }
    }
    
    @Published var worklistModel: WorklistViewModel
    
    init(episode: MedicalEpisode, worklistmodel:WorklistViewModel){
        self.episode = episode
        self.worklistModel = worklistmodel
        self.diagnosis = episode.diagnosis?.icd10Description ?? "Diagnosis"
        self.patientName = episode.patient?.name ?? "No name"
        self.roomNumber = episode.roomLocation ?? "room"
    }
    
    func chooseDiagnosis(){
        worklistModel.activeSheet = .showIdCard
        worklistModel.selectedEpisode = episode
    }
    
    func chooseRoom(){
        worklistModel.activeSheet = .editRoom; worklistModel.selectedEpisode = episode
    }
    func editPatient(){
        worklistModel.activeSheet = .showIdCard; worklistModel.selectedEpisode = episode
    }
    func addAct(){
        worklistModel.activeSheet = .addAct; worklistModel.selectedEpisode = episode
    }
}

struct MedicalEpisodeRow: View {
    @Environment(\.presentationMode) var presentationMode
//    @ObservedObject var episode: MedicalEpisode
//    @ObservedObject var worklistModel: WorklistViewModel
    @ObservedObject var rowModel: MedicalEpisodeRowViewModel
    
    @State private var showFullCard: Bool = false
//    private var expandCard: Bool {return showFullCard && episode.acts?.count != 0}
//    private var couldExpand: Bool {return episode.acts?.count != 0}
//    private var noActs: Bool {return showFullCard && episode.acts.isNull}
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    
    var body: some View {
        VStack{
            HStack (alignment: .top) {
                HStack (alignment: .center){
                    Button(action: rowModel.editPatient){Image(systemName: "person.crop.circle.fill").font(.title2)}
                    Text(rowModel.patientName).fontWeight(.bold)
                }
                Spacer()
                Button(action: rowModel.chooseDiagnosis){ Text(rowModel.diagnosis).fontWeight(.bold)}
                    .padding(.horizontal)
                Button(action: rowModel.addAct){Image(systemName: "plus")}
            }.lineLimit(2).buttonStyle(PlainButtonStyle())
            Spacer()
            Divider()

            if rowModel.expandCard {
                VStack (alignment: .leading){
                    ActListView(model: ActListViewModel(episode: rowModel.episode), selectedAct: $rowModel.worklistModel.selectedAct, activeSheet: $rowModel.worklistModel.activeSheet)
                    
                    HStack(alignment:.bottom){
                        Button(action:{}){Text("Consulting MD")}; Spacer()
                        Button(action:{}){Label("Notes", systemImage: "note.text")}; Spacer()
                        Button(action:{}){Image(systemName: "flag")}
                    }.font(.subheadline).lineLimit(1)
                    Divider()
                }
            }

            HStack{
                Group{
                    Button(action: rowModel.chooseRoom){Label(rowModel.roomNumber, systemImage: "bed.double")}
                    Label("#00000", systemImage: "folder")
                    Label("Last seen", systemImage: "clock")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
            }
        }
        .padding()
        .frame(height: rowModel.cardHeight)
        .background(Color.Aliceblue)
        .cornerRadius(10.0)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)

        .onTapGesture {
            rowModel.expandCard.toggle()
//            if couldExpand {
//                withAnimation{
//                    showFullCard.toggle()
//                    worklistModel.hideActionButton = expandCard
//                }
//            }
        }
    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
