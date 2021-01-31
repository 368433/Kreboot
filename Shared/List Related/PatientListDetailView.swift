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
        VStack(alignment:.leading, spacing:0){
            HStack(alignment:.top){
                Text(list.wrappedTitle).font(.title).fontWeight(.heavy)
                VStack (alignment:.leading){
                    Text("Semaine du "+list.dayLabel(dateStyle: .medium)).font(.footnote)
                    Text("some other useful information").font(.footnote)
                }.lineLimit(1).foregroundColor(.secondary)
            }.padding()
            List {
                ForEach(list.patientsArray, content: PatientRowView.init)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
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
