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
        List {
            ForEach(list.patientsArray, content: PatientRowView.init)
        }
        
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("List Detail").fontWeight(.bold)
            }
            
            ToolbarItem(placement: .primaryAction){
                HStack {
                    Button(action: {showEditListForm.toggle()}){Image(systemName: "square.and.pencil")}
                    Button(action: {showAddForm.toggle()}){Image(systemName: "person.crop.circle.badge.plus")}
                }.sheet(isPresented: $showEditListForm, content: {
                    ListFormView(list: list)
                })
            }
        }.sheet(isPresented: $showAddForm, content: {
            AddPatientToListView(list: list).environment(\.managedObjectContext, viewContext)
        })
    }
}
