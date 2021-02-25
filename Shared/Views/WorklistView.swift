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
    @ObservedObject private var model: WorklistViewModel
    
    init(list: PatientsList ){
        self.model = WorklistViewModel(patientsList: list)
        self.model.cardsFilter = .toSee
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            WorklistCardsList(model: model).offset(y:10)
            VStack{
                ZStack(alignment: .topLeading){
                    WorklistTitleHeader(model: model)
                    Button(action:{self.presentationMode.wrappedValue.dismiss()}){Image(systemName:"xmark").font(.title3)}.padding()
                }
                WorklistHeaderButtons(model: model)
            }
            
        }
        .sheet(item: $model.activeSheet) { item in
            switch item {
            case .editListDetails:
                NavigationView{ListFormView(list: model.list)}.environment(\.managedObjectContext, self.viewContext)
            case .addPatient:
                NavigationView{PatientFormView(to: model.list, newEpisode: true)}.environment(\.managedObjectContext, self.viewContext)
            case .addAct:
                ActFormView(for: nil, in: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            case .medicalEpisodeFormView:
                if let episode = model.selectedEpisode {
                    MedicalEpisodeFormView(episode: episode).environment(\.managedObjectContext, self.viewContext)
                }
            case .editRoom:
                RoomChangeView(episode: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            default:
                EmptyView()
            }
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistView(list: PersistenceController.singleList)
    }
}
