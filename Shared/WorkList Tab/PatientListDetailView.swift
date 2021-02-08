//
//  PatientListDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientListDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var activeSheet: ActiveSheet?
    @ObservedObject var list: PatientsList
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(alignment:.leading){
                    ListTopDetailView(list: list, editAction: {activeSheet = .second})
                    VStack {
                        ForEach(list.patientsArray, id:\.self){ patient in
                            PatientRow2(patient: patient)
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
                    PatientFormView().environment(\.managedObjectContext, viewContext)
                }
            default:
                EmptyView()
            }
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
