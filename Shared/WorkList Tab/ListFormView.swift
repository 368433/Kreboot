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
    
    init(list: PatientsList? = nil ){
        self.viewModel = ListFormViewModel(list: list)
    }
    
    var body: some View {
        Form{
            Section(
                header: Text("LIST NAME"),
                footer:HStack {
                    Text("Sugg.: ").font(.caption2)
                    ScrollChoice(labelText: $viewModel.title, choice: SomeConstants.listTitleChoice )
                }
            ){ TextField("Name", text: $viewModel.title)}
            Section(header: Text("DETAILS")) {
                TextField("List description", text: $viewModel.listDescription)
                HStack {
                    Text("Pin")
                    Spacer()
                    Button(action: {viewModel.isPinned.toggle()}){Image(systemName: viewModel.isPinned ? "pin.fill":"pin")}
                }
                Toggle(isOn: $viewModel.isArchived){Text("Archive")}.padding(.trailing)
                DatePicker("Date created", selection: $viewModel.date, displayedComponents: .date)
            }
        }
        .navigationBarTitle(Text("List Form"))
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Save", action: {
                    viewModel.save()
                    self.presentationMode.wrappedValue.dismiss()
                })
                    .disabled(!viewModel.formIsValid)
            }
        }
    }
}

struct ListFormView_Previews: PreviewProvider {
    static var previews: some View {
        ListFormView()
    }
}
