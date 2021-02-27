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
    
    private var buttonHeight: CGFloat = 32
    
    init(list: PatientsList ){
        self.model = WorklistViewModel(patientsList: list)
        self.model.cardsFilter = .toSee
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            VStack(spacing: 0){
                ZStack(alignment: .topLeading){
                    Button(action:{self.presentationMode.wrappedValue.dismiss()}){Image(systemName:"xmark").font(.title3)}.padding()
                    WorklistTitleHeader(model: model)
                }
                ZStack(alignment: .top){
                    WorklistCardsList(model: model)
                    ZStack{
                        Rectangle().frame(height: 1).foregroundColor(.yellow)
                        WorklistHeaderButtons(model: model).frame(height: buttonHeight)
                    }.offset(y: -buttonHeight/2)
                }
            }
            WorklistOptionsView(model: model)
            
        }.animation(.easeIn(duration: Karla.animationSpeed))
        .sheet(item: $model.activeSheet) { item in
            switch item {
            case .editListDetails:
                ListFormView(list: model.list).environment(\.managedObjectContext, self.viewContext)
            case .addPatient:
                NavigationView{PatientFormView(to: model.list, newEpisode: true)}.environment(\.managedObjectContext, self.viewContext)
            case .addAct:
                ActFormView(for: nil, in: model.selectedEpisode).environment(\.managedObjectContext, self.viewContext)
            case .medicalEpisodeFormView:
                if let episode = model.selectedEpisode {
                    MedicalEpisodeFormView(episode: episode).environment(\.managedObjectContext, self.viewContext)
                }
            case .editRoom:
                if let episode = model.selectedEpisode {
                    RoomChangeView(episode: episode).environment(\.managedObjectContext, self.viewContext)
                }
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
