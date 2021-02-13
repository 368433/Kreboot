//
//  WorklistView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct WorklistView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var model: WorklistViewModel = WorklistViewModel()
    @State private var cardsGroup: CardsFilter = .toSee
    
    init(list: PatientsList? = nil ){
        self.model.list = list
    }
    
    var body: some View {
        ZStack{
            if model.isEmpty{
                EmptyWorklistView(action: {model.activeSheet = .showAllLists}).offset(y:-50)
            }
            if !model.isEmpty{
                ZStack(alignment: .bottomTrailing){
                    VStack {
                        WorklistHeaderView(for: model)
                        
                        if let listToShow = model.list {
                            ScrollView {
                                VStack(spacing:-6){
                                    ForEach(listToShow.patientsArray, id:\.self){ patient in
                                        PatientRow2(patient: patient, model: model)
                                    }.padding()
                                }
                            }
                        }
                    }
                    WorklistActionButtons(for: model)
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
                NavigationView{PatientFormView(to: model.list)}.environment(\.managedObjectContext, self.viewContext)
            case .setDiagnosis:
                ICDListView().environment(\.managedObjectContext, self.viewContext)
            case .showIdCard:
                NavigationView{PatientFormView(patient: model.selectedCard)}.environment(\.managedObjectContext, self.viewContext)
            case .editRoom:
                RoomChangeView().environment(\.managedObjectContext, self.viewContext)
            case .addAct:
                AddActView().environment(\.managedObjectContext, self.viewContext)
            case .showAllLists:
                PatientsListsView(selectedList: $model.list).environment(\.managedObjectContext, self.viewContext)
            }
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistView(list: PersistenceController.singleList)
    }
}
