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
    
    init(episode: MedicalEpisode, worklistModel: WorklistViewModel){
        self.rowModel = MedicalEpisodeRowViewModel(episode: episode, worklistmodel: worklistModel)
    }
    
    
    var body: some View {
        VStack{
            HStack{
                //button image person
                Button(action: rowModel.editPatient){Image(systemName: "person.crop.circle.fill").font(.title2)}
                //Vstack name and diagnosis
                HStack{
                    Text(rowModel.patientName).fontWeight(.bold).lineLimit(1)
                    Button(action: rowModel.chooseDiagnosis){ Text(rowModel.diagnosis).font(.footnote)}.lineLimit(2)
                }
                Spacer()
                //button add act
                Button(action: rowModel.addAct){Image(systemName: "plus")}
            }.buttonStyle(PlainButtonStyle())
            
            Divider()

            ActListView(model: ActListViewModel(episode: rowModel.episode), selectedAct: $rowModel.worklistModel.selectedAct, activeSheet: $rowModel.worklistModel.activeSheet)
            HStack(alignment:.bottom){
                Button(action:{}){Text("Consulting MD")}; Spacer()
                Button(action:{}){Label("Notes", systemImage: "note.text")}; Spacer()
                Button(action:{}){Image(systemName: "flag")}
            }.font(.subheadline).lineLimit(1)
            
            Divider()

            HStack{
                Group{
                    Button(action: rowModel.chooseRoom){Label(rowModel.roomNumber, systemImage: "bed.double")}
                    Label("#00000", systemImage: "folder")
                    Label("Last seen", systemImage: "clock")
                }.foregroundColor(.secondary).font(.caption).lineLimit(1)
            }
        }
        .padding()
        .background(Color.Aliceblue)
        .cornerRadius(10.0)
        .shadow(color: Color.gray.opacity(0.4), radius: 10, y: 10)

    }
}

//struct MedicalEpisodeRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MedicalEpisodeRow(episode: PersistenceController.singleMedicalEpisode, worklistModel: WorklistViewModel())
//    }
//}
