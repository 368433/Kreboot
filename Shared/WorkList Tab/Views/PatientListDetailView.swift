//
//  PatientListDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

//view model

struct PatientListDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var model: WorklistViewModel = WorklistViewModel()
    @State private var cardsGroup: CardsFilter = .toSee
    
    init(list: PatientsList? = nil ){
        print("From patientslistdetailview init:")
        print(viewContext)
        
        print("\n From patientslistdetailview init BUT PERSISTENT STATIC")
        print(PersistenceController.shared.container.viewContext)
        self.model.list = list
    }
    
    var body: some View {
        ZStack(alignment: .top){
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        ListTopDetailView(title: "", details: "Liste semaine du \( model.list?.dayLabel(dateStyle: .medium) ?? "NO LIST")",editAction: {model.activeSheet = .editListDetails}).padding(.vertical)
                        if let listToShow = model.list {
                            ForEach(listToShow.patientsArray, id:\.self){ patient in
                                PatientRow2(patient: patient, model: model)
                            }
                        }
                    }.padding(.horizontal).offset(y: 30)
                }
                VStack{
                    Button(action: {model.activeSheet = .searchPatients}){Image(systemName: "plus.magnifyingglass")}
                    Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}
                }.font(.title3).buttonStyle(CircularButton()).padding()
            }
            Picker("Cards filter", selection: $cardsGroup) {
                ForEach(CardsFilter.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
//        .navigationBarTitle(model.list?.title ?? "No List")
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {model.activeSheet = .showAllLists; print("From patientslistdetail view"); print(viewContext)}){Image(systemName: "doc.text.magnifyingglass")}
            }
        })
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
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
