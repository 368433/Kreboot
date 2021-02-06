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
                TopDetailView(listTitle: list.wrappedTitle, dayLabel: list.dayLabel(dateStyle: .medium), editAction: {showEditListForm.toggle()})
                
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

struct TopDetailView: View {
    var listTitle: String
    var dayLabel: String
    var editAction: ()->Void

    
    var body: some View{
        HStack(alignment:.center){
            Text(listTitle).font(.title).fontWeight(.heavy).lineLimit(3)
            VStack (alignment:.leading){
                Text("Semaine du " + dayLabel).font(.footnote)
                Text("some other useful information").font(.footnote)
            }.lineLimit(2).foregroundColor(.secondary)
            Spacer()
            Button(action: editAction){Text("Edit").font(.caption)}.buttonStyle(CapsuleButton())
        }.padding(.bottom)
    }
}


struct PatientListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PatientListDetailView(list: PersistenceController.singleList)
    }
}
