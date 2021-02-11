//
//  AddPatientToListView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct AddPatientToListView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var searchText: String = ""
    @State private var showNewPatientForm: Bool = false
    var list: PatientsList
    var predicate: NSPredicate? {
        return searchText == "" ? nil : NSPredicate(format: "name CONTAINS[cd] %@", searchText)
    }
       
    var body: some View {
        VStack{
            SearchBar(text: $searchText).padding([.horizontal,.top])
            List {
                CoreDataProvider(sorting: [NSSortDescriptor(keyPath: \Patient.name, ascending: true)], predicate: predicate ) { (patient: Patient) in
                    PatientRowAddView(patient: patient, list: list)
                }
            }
        }
        .sheet(isPresented: $showNewPatientForm, content: {PatientFormView()})
    }
}

struct AddPatientToListView_Previews: PreviewProvider {
    static var previews: some View {
        AddPatientToListView(list: PersistenceController.singleList).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
