//
//  ListFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct ListFormView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject private var viewModel: ListFormViewModel
    @State private var textfieldsSelected: Bool = false
    @State private var descriptionSelected: Bool = false
    private var blankForm: Bool
    
    init(list: PatientsList? = nil ){
        self.viewModel = ListFormViewModel(list: list)
        blankForm = list != nil ? false:true
    }
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            HStack{
//                Text(blankForm ? "Create New List":"Edit List").font(.largeTitle).fontWeight(.heavy)
                Spacer()
                Button(action:{viewModel.isPinned.toggle()}){Image(systemName: viewModel.isPinned ? "pin.fill":"pin")}
                Button(action:{viewModel.isArchived.toggle()}){Image(systemName: viewModel.isArchived ? "archivebox.fill":"archivebox")}.padding(.horizontal)
                Button(action:{
                    viewModel.save()
                    self.presentationMode.wrappedValue.dismiss()
                }){Text("Save")}.disabled(!viewModel.formIsValid)
            }.padding()
            
//            HStack{
//                Spacer()
//                Button(action:{viewModel.isPinned.toggle()}){Image(systemName: viewModel.isPinned ? "pin.fill":"pin")}
//                Button(action:{viewModel.isArchived.toggle()}){Image(systemName: viewModel.isArchived ? "archivebox.fill":"archivebox")}.padding(.horizontal)
//            }.font(.title3)
            
            ScrollView{
                VStack{
                    VStack(alignment: .leading){
                        Text("List title".uppercased()).foregroundColor(.secondary).font(.caption)
                        TextField("", text: $viewModel.title)
                            .borderedK(text: $viewModel.title, show: $textfieldsSelected)
                            .onTapGesture {
                                self.textfieldsSelected = true
                                self.descriptionSelected = false
                            }
                    }.padding([.horizontal])
                        
                    HStack {
                        Text("Sugg.: ").font(.caption2).foregroundColor(.secondary)
                        ScrollChoice(labelText: $viewModel.titleSuggestion, choice: SomeConstants.listTitleChoice )
                    }
                    
                    VStack(alignment: .leading){
                        Text("List description".uppercased())
                            .foregroundColor(.secondary).font(.caption)
                        TextEditor(text: $viewModel.listDescription)
                            .frame(height: 120)
                            .borderedK(text: $viewModel.listDescription, show: $descriptionSelected)
                            .font(.callout)
                            .onTapGesture {
                                self.descriptionSelected = true
                                self.textfieldsSelected = false
                            }
                    }.padding()
                    
                    DatePicker("Date created", selection: $viewModel.date, displayedComponents: .date).datePickerStyle(GraphicalDatePickerStyle())
                    
                }.padding(.horizontal)
            }
        }.animation(.default)
    }
}


struct ListFormView_Previews: PreviewProvider {
    static var previews: some View {
        ListFormView()
    }
}
