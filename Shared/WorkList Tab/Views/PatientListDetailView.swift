//
//  PatientListDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

//view model
class WorklistViewModel: ObservableObject {
    @Published var list: [String]? = nil
    @Published var selectedCard: Patient? = nil
    @Published var activeSheet: ActiveSheet? = nil
}

struct PatientListDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var model: WorklistViewModel = WorklistViewModel()
    @ObservedObject var list: PatientsList
    
    @State private var cardsGroup: CardsFilter = .toSee
    
    var body: some View {
        ZStack(alignment: .top){
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    VStack {
                        ListTopDetailView(title: "", details: "Liste semaine du \( list.dayLabel(dateStyle: .medium))",editAction: {model.activeSheet = .editListDetails}).padding(.vertical)
                        ForEach(list.patientsArray, id:\.self){ patient in
                            PatientRow2(patient: patient, model: model)
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
        .navigationBarTitle(list.title ?? "List")
        .toolbar(content: {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {model.activeSheet = .showAllLists}){Image(systemName: "doc.text.magnifyingglass")}
            }
        })
        .sheet(item: $model.activeSheet) { item in
            switch item {
            case .searchPatients:
                AddPatientToListView(list: list).environment(\.managedObjectContext, viewContext)
            case .editListDetails:
                NavigationView{ListFormView(list: list).environment(\.managedObjectContext, viewContext)}
            case .addPatient:
                NavigationView{PatientFormView(list: list).environment(\.managedObjectContext, viewContext)}
            case .setDiagnosis:
                ICDListView().environment(\.managedObjectContext, viewContext)
            case .showIdCard:
                NavigationView{PatientFormView(patient: model.selectedCard).environment(\.managedObjectContext, viewContext)}
            case .editRoom:
                RoomChangeView()
            case .addAct:
                AddActView()
            case .showAllLists:
                PatientsListsView()
//            default:
//                EmptyView()
            }
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
