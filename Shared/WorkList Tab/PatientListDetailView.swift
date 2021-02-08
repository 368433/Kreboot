//
//  PatientListDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientListDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var list: PatientsList
    @ObservedObject var monitor = MonitorPt()
    @State private var activeSheet: ActiveSheet?
    @State private var cardsGroup: CardsFilter = .toSee
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment:.leading){
                    ListTopDetailView(list: list, editAction: {activeSheet = .second})
                    Picker("Cards filter", selection: $cardsGroup) {
                        ForEach(CardsFilter.allCases, id:\.self){option in
                            Text(option.label).tag(option)
                        }
                    }.pickerStyle(SegmentedPickerStyle()).padding(.vertical)
                    VStack {
                        ForEach(list.patientsArray, id:\.self){ patient in
                            PatientRow2(
                                patient: patient,
                                dxAction: {
                                monitor.pt = patient
                                activeSheet = .fourth
                            },
                                idCardAction: {
                                    monitor.pt = patient
                                    activeSheet = .fifth
                                })
                        }
                    }
                }.padding()
            }
            VStack{
                Button(action: {activeSheet = .first}){Image(systemName: "plus.magnifyingglass")}
                Button(action: {activeSheet = .third}){Image(systemName: "person.crop.circle.badge.plus")}
            }.font(.title3).buttonStyle(CircularButton()).padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $activeSheet) { item in
            switch item {
            case .first:
                AddPatientToListView(list: list).environment(\.managedObjectContext, viewContext)
            case .second:
                NavigationView{
                    ListFormView(list: list).environment(\.managedObjectContext, viewContext)
                }
            case .third:
                NavigationView{
                    PatientFormView(list: list).environment(\.managedObjectContext, viewContext)
                }
            case .fourth:
                ICDListView().environment(\.managedObjectContext, viewContext)
            case .fifth:
                NavigationView{
                    PatientFormView(patient: monitor.pt).environment(\.managedObjectContext, viewContext)
                }
            default:
                EmptyView()
            }
        }
    }
}

class MonitorPt: ObservableObject {
    @Published var pt: Patient?
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
