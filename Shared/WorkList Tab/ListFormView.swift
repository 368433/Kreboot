//
//  ListFormView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

struct ListFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var list: PatientsList
    var disableSave: Bool { return list.title?.isEmpty ?? true }
    
    init(list: PatientsList? = nil ){
        self.list = list ?? PatientsList(context: PersistenceController.shared.container.viewContext)
    }
    
    var body: some View {
        List{
            TextField("Title", text: $list.title ?? "")
            ScrollChoice(labelText: $list.title ?? "", choice: SomeConstants.listTitleChoice )
            TextField("List description", text: $list.listDescription ?? "")
            HStack {
                Text("Favorite")
                Spacer()
                Button(action: {list.isFavorite.toggle()}){Image(systemName: list.isFavorite ? "star.fill":"star")}
            }
            Toggle(isOn: $list.isArchived){Text("Archive")}.padding(.trailing)
            DatePicker("Date created", selection: $list.dateCreated ?? Date(), displayedComponents: .date)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Save", action: Save)
                    .disabled(disableSave)
            }
        }
    }
    
    private func Save() -> Void {
        list.saveYourself(in: viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ListFormView_Previews: PreviewProvider {
    static var previews: some View {
        ListFormView()
    }
}
