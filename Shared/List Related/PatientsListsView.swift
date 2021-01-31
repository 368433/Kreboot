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
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \PatientsList.title, ascending: true)], animation: .default)
    private var lists: FetchedResults<PatientsList>
    
    @State private var presentForm: Bool = false
    @State private var listGroup: ListFilterEnum = .favorite
    
    var body: some View {
        VStack{
            Picker("Test", selection: $listGroup) {
                ForEach(ListFilterEnum.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
            List {
                DynamicFilteredList(sorting: listGroup.descriptors, predicate: listGroup.predicate) { (list: PatientsList) in
                    NavigationLink(destination: PatientListDetailView(list: list)){ListRow(list: list)
                    }
                }
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .principal){
                Text("Lists").font(.largeTitle).fontWeight(.bold)
            }
            ToolbarItem(placement: .primaryAction){
                Button(action: addList){Image(systemName: "plus")}
                    .sheet(isPresented: $presentForm, content: {ListFormView()})
            }
        }
    }
    
    private func addList(){
        presentForm.toggle()
    }
}



struct PatientsListsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsListsView()
    }
}
