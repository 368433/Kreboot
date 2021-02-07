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
    
    var list: PatientsList?
    var defaultStar: Bool
    var disableSave: Bool { return title == "" }
    
    @State var title: String
    @State var listDescription: String
    @State var isArchived: Bool
    @State var isFavorite: Bool
    @State var dateCreated: Date
    
    init(list: PatientsList? = nil, starred: Bool = false ){
        self.defaultStar = starred
        self.list = list
        self._title = State(initialValue: list?.title ?? "")
        self._listDescription = State(initialValue: list?.listDescription ?? "")
        self._dateCreated = State(initialValue: list?.dateCreated ?? Date())
        self._isArchived = State(initialValue: list?.isArchived ?? false)
        self._isFavorite = State(initialValue: starred ? true:(list?.isFavorite ?? false))
    }
    
    var body: some View {
        List{
            TextField("Title", text: $title)
                .labeledTF(label: "Title", isEmpty: title == "")
            ScrollChoice(labelText: $title, choice: SomeConstants.listTitleChoice )
            TextField("List description", text: $listDescription)
                .labeledTF(label: "List description", isEmpty: listDescription == "")
            HStack {
                Text("Favorite")
                Spacer()
                Button(action: {isFavorite.toggle()}){Image(systemName: isFavorite ? "star.fill":"star")}
            }
            Toggle(isOn: $isArchived){Text("Archive")}.padding(.trailing)
            DatePicker("Date created", selection: $dateCreated, displayedComponents: .date)            
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
        // TODO Add message to confirm overwriting changes
        guard title != "" else { return }
        
        let listToSave = list ?? PatientsList(context: viewContext)
        listToSave.title = self.title
        listToSave.listDescription = self.listDescription
        listToSave.dateCreated = self.dateCreated
        listToSave.isFavorite = self.isFavorite
        listToSave.isArchived = self.isArchived
        listToSave.saveYourself(in: viewContext)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct ListFormView_Previews: PreviewProvider {
    static var previews: some View {
        ListFormView()
    }
}
