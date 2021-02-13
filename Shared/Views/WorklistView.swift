//
//  WorklistView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

//view model

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
                        VStack(alignment: .leading) {
                            Button(action:{model.list = nil}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
                            HStack(alignment: .top){
                                VStack(alignment: .leading){
                                    Text(model.isEmpty ? "" : model.listTitle).font(.largeTitle).fontWeight(.black).lineLimit(1).minimumScaleFactor(0.4)
                                    Text(model.isEmpty ? "":"Week of \(model.list?.dayLabel(dateStyle: .medium) ?? "No date")")
                                }
                                Spacer()
                                VStack (alignment: .trailing){
                                    Button(action: {model.activeSheet = .editListDetails}){Text("Edit").font(.caption)}.buttonStyle(CapsuleButton()).disabled(model.isEmpty)
                                    Button(action: {model.activeSheet = .showAllLists}){Text("Open").font(.caption)}.buttonStyle(CapsuleButton())
                                }
                            }
                            Picker("Cards filter", selection: $cardsGroup) {
                                ForEach(CardsFilter.allCases, id:\.self){option in
                                    Text(option.label).tag(option)
                                }
                            }.pickerStyle(SegmentedPickerStyle()).disabled(model.isEmpty)
                        }.padding(.horizontal)
                        
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
                    VStack{
                        Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}.hidden()
                        Button(action: {model.activeSheet = .searchPatients}){Image(systemName: "plus.magnifyingglass")}.disabled(model.isEmpty)
                        Button(action: {model.activeSheet = .addPatient}){Image(systemName: "person.crop.circle.badge.plus")}.disabled(model.isEmpty)
                    }.font(.title3).buttonStyle(CircularButton()).padding()
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
