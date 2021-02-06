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
                TopDetailView(listTitle: list.wrappedTitle, dayLabel: list.dayLabel(dateStyle: .medium))
                VStack {
                    ForEach(list.patientsArray, id:\.self){ patient in
                        PatientRow2(patient: patient)
                    }
                }
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

struct TopDetailView: View {
    var listTitle: String
    var dayLabel: String
    
    var body: some View{
        HStack(alignment:.top){
            Text(listTitle).font(.title).fontWeight(.heavy).lineLimit(3)
            VStack (alignment:.leading){
                Text("Semaine du " + dayLabel).font(.footnote)
                Text("some other useful information").font(.footnote)
            }.lineLimit(1).foregroundColor(.secondary)
        }.padding()
    }
}


struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
