//
//  PatientsListsView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientsListsView: View {
    @State private var presentForm: Bool = false
    @State private var listGroup: ListFilterEnum = .active
    
    var body: some View {
        VStack {
            HStack {
                Picker("List filter", selection: $listGroup) {
                    ForEach(ListFilterEnum.allCases, id:\.self){option in
                        Text(option.label).tag(option)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                Spacer()
                Button(action: {presentForm.toggle()}){Image(systemName: "plus")}
            }.padding()
            List {
                CoreDataProvider(sorting: listGroup.descriptors, predicate: listGroup.predicate) { (list: PatientsList) in
                    NavigationLink(destination: PatientListDetailView(list: list)){
                        ListRow(list: list)
                    }
                }
            }.sheet(isPresented: $presentForm, content: {
                NavigationView{ListFormView()}
            })
        }
    }
}

struct PatientsListsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsListsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
