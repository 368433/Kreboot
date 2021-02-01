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
                HStack(alignment:.top){
                    Text(list.wrappedTitle).font(.title).fontWeight(.heavy)
                    VStack (alignment:.leading){
                        Text("Semaine du "+list.dayLabel(dateStyle: .medium)).font(.footnote)
                        Text("some other useful information").font(.footnote)
                    }.lineLimit(1).foregroundColor(.secondary)
                }.padding()
                VStack (spacing: 5){
                    ForEach(list.patientsArray){ patient in
                        PatientRow2(patient: patient)
                    }
                }
    //            List {
    //                ForEach(list.patientsArray, content: PatientRowView.init)
    //                ForEach(list.patientsArray){ patient in
    //                DisclosureGroup(
    //                    content: { Text("test") },
    //                    label: { PatientRowView(patient: patient) }
    //                )}
    //            }
                Spacer()
            }.padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    HStack {
                        Button(action: {showEditListForm.toggle()}){Image(systemName: "square.and.pencil").font(.body)}
                        Button(action: {showAddForm.toggle()}){Image(systemName: "plus.rectangle.on.rectangle").font(.body)}
                    }.sheet(isPresented: $showEditListForm, content: {
                        ListFormView(list: list)
                    })
                }
            }.sheet(isPresented: $showAddForm, content: {
                AddPatientToListView(list: list).environment(\.managedObjectContext, viewContext)
        })
        }
    }
}

struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
