//
//  PatientsListsView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientsListsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var presentForm: Bool = false
    @State private var listGroup: ListFilterEnum = .active
    
    var body: some View {
        VStack{
            Picker("Test", selection: $listGroup) {
                ForEach(ListFilterEnum.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
            List {
                DynamicFilteredList(sorting: listGroup.descriptors, predicate: listGroup.predicate) { (list: PatientsList) in
                    NavigationLink(destination: PatientListDetailView(list: list)){
                        ListRow(list: list)
                    }
                }
            }.listStyle(PlainListStyle())
            Spacer()
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

private func update(_ result: FetchedResults<PatientsList>) -> [[PatientsList]] {
    return Dictionary(grouping: result) {(element: PatientsList) in
        element.wrappedTitle
    }.values.map{$0}
}

struct PatientsListsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsListsView()
    }
}
