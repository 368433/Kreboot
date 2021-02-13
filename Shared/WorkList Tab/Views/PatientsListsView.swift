//
//  PatientsListsView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct PatientsListsView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var presentForm: Bool = false
    @State private var listGroup: ListFilterEnum = .active
    @Binding var selectedList: PatientsList?

    init(selectedList: Binding<PatientsList?>){
        self._selectedList = selectedList
        print("\n From patientsListsView init")
        print(viewContext)
    }

    var body: some View {
        VStack {
            HStack {
                Picker("List filter", selection: $listGroup) {
                    ForEach(ListFilterEnum.allCases, id:\.self){option in
                        Text(option.label).tag(option)
                    }
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                Spacer()
                Button(action: {presentForm.toggle(); print("\n From patientslistsView BUTTON"); print(viewContext)}){Image(systemName: "plus")}
            }.padding()
            List {
                CoreDataProvider(sorting: listGroup.descriptors, predicate: listGroup.predicate) { (list: PatientsList) in
                    ListRow(list: list)
                        .onTapGesture{
                            selectedList = list
                            self.presentationMode.wrappedValue.dismiss()
                        }
                }
            }.sheet(isPresented: $presentForm, content: {
                NavigationView{ListFormView()}.environment(\.managedObjectContext, self.viewContext)
            })
        }
    }
}

struct PatientsListsView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsListsView(selectedList: .constant(nil)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
