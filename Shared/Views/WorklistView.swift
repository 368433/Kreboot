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
    
    init(list: PatientsList? = nil ){
        self.model.list = list
        self.model.cardsFilter = .toSee
    }
    
    var body: some View {
        ZStack{
            if model.isEmpty{
                EmptyWorklistView(action: {model.activeSheet = .showAllLists}).offset(y:-50)
            }
            if !model.isEmpty{
                ZStack(alignment: .top) {
                    WorklistCardsList(model: model).offset(y:10)
                    VStack{
                        ZStack(alignment: .topLeading){
                            WorklistTitleHeader(model: model)
                            Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.offset(x: 25.0, y: 10.0)
                        }
                        WorklistHeaderButtons(model: model)
                    }
                }//.padding(.top, 5)
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
            case .addAct:
                ActFormView(for: nil, in: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            case .showAllLists:
                WorklistNavigatorView(selectedList: $model.list).environment(\.managedObjectContext, self.viewContext)
            case .medicalEpisodeFormView:
                if let episode = model.selectedEpisode {
                    MedicalEpisodeFormView(episode: episode).environment(\.managedObjectContext, self.viewContext)
                }
            case .editRoom:
                RoomChangeView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            }
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistView(list: PersistenceController.singleList)
    }
}
