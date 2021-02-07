//
//  PatientListDetailView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientListDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var showAddForm: Bool = false
    @State private var showEditListForm: Bool = false
    @ObservedObject var list: PatientsList
    
    var body: some View {
        ScrollView {
            VStack(alignment:.leading){
                ListTopDetailView(list: list, editAction: {showEditListForm.toggle()})
                VStack {
                    ForEach(list.patientsArray, id:\.self){ patient in
                        PatientRow2(patient: patient)
                    }
                }
            }.padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    HStack (spacing: 10) {
                        Button(action: {showAddForm.toggle()}){
                            Image(systemName: "person.crop.circle.badge.plus").font(.title2)
                        }
                        Button(action: {showAddForm.toggle()}){
                            Image(systemName: "doc.text.viewfinder").font(.title2)
                        }
                    }.sheet(isPresented: $showAddForm, content: {
                        AddPatientToListView(list: list).environment(\.managedObjectContext, viewContext)
                    })
                }
            }
            .sheet(isPresented: $showEditListForm, content: {
                NavigationView{ListFormView(list: list)}
            })
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
