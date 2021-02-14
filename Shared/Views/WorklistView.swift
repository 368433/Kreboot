//
//  WorklistView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct WorklistView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject private var model: WorklistViewModel = WorklistViewModel()
    @State private var cardsGroup: CardsFilter = .toSee
    
    init(list: PatientsList? = nil ){
        self.model.list = list
    }
    
    var body: some View {
        Group{
            if model.isEmpty{
                EmptyWorklistView(action: {model.activeSheet = .showAllLists}).offset(y:-50)
            }
            if !model.isEmpty{
                ZStack(alignment: .bottomTrailing){
                    VStack {
                        WorklistHeaderView(for: model)
                        
                        ScrollView {
                            VStack(spacing:-6){
                                ForEach(model.medicalEpisodes(sortedBy:[.name], true), id:\.self){ episode in 
                                    MedicalEpisodeRow(episode: episode, model: model)
                                }.padding()
                            }
                        }
                    }
                    WorklistActionButtons(for: model).opacity(model.hideActionButton ? 0:1)
                }
            }
        }
        .sheet(item: $model.activeSheet) { item in
            switch item {
            case .searchPatients:
                AddPatientToListView(list: model.list).environment(\.managedObjectContext, self.viewContext)
            case .editListDetails:
                NavigationView{ListFormView(list: model.list)}.environment(\.managedObjectContext, self.viewContext)
            case .addPatient:
                NavigationView{PatientFormView(to: model.list, newEpisode: true)}.environment(\.managedObjectContext, self.viewContext)
            case .setDiagnosis:
                DiagnosisSearchView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
//                ICDListView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            case .showIdCard:
                NavigationView{PatientFormView(patient: model.selectedEpisode?.patient, newEpisode: false)}.environment(\.managedObjectContext, self.viewContext)
            case .editRoom:
                RoomChangeView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            case .addAct:
                ActFormView(for: nil, in: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            case .showAllLists:
                WorklistNavigatorView(selectedList: $model.list).environment(\.managedObjectContext, self.viewContext)
            case .actFormView:
                ActFormView(for: model.selectedAct, in: nil).environment(\.managedObjectContext, self.viewContext)
            }
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistView(list: PersistenceController.singleList)
    }
}
