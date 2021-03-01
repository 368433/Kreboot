//
//  WorklistHomeViewVariation2.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct WorklistHomeViewVariation2: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var presentForm: Bool = false
    @State private var listGroup: ListFilterEnum = .active
    @Binding var selectedList: PatientsList?

    var body: some View {
        VStack (alignment: .center){
            
            HStack {
                Text("Worklists").font(.largeTitle).fontWeight(.black)
                Spacer()
                HStack{
                    Button(action: {presentForm.toggle()}){Image(systemName:"plus")}
                    Button(action:{self.presentationMode.wrappedValue.dismiss()}){Text("Close")}
                }
            }.padding([.top, .horizontal])
            
            Picker("List filter", selection: $listGroup) {
                ForEach(ListFilterEnum.allCases, id:\.self){option in
                    Text(option.label).tag(option)
                }
            }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)

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

