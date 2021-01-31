//
//  SectionnedPatientsList.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct SectionnedPatientsList: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: PatientsList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PatientsList.title, ascending: true)], animation: .default)
    private var lists: FetchedResults<PatientsList>
    
    @State private var presentForm: Bool = false
    @State private var listGroup: ListFilterEnum = .favorite
    
    var body: some View {
        List(lists) { list in
            ListRow(list: list)
        }
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("Lists").font(.largeTitle).fontWeight(.bold)
            }
            ToolbarItem(placement: .primaryAction){
                Button(action: {presentForm.toggle()}){Image(systemName: "plus")}
            }
        }.sheet(isPresented: $presentForm, content: {ListFormView()})
    }
}

struct SectionnedPatientsList_Previews: PreviewProvider {
    static var previews: some View {
        SectionnedPatientsList()
    }
}
