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
    
    var list : PatientsList?
    var defaultStar: Bool
    var disableSave: Bool {
        return title == ""
    }
    
    @State var title: String = ""
    @State var listDescription: String = ""
    @State var isArchived: Bool = false
    @State var isFavorite: Bool = false
    @State var dateCreated: Date = Date()
    
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
        ScrollView{
            VStack (alignment: .center) {
                VStack (alignment: .leading, spacing: 2){
                    Text("List").font(.largeTitle)
                    Divider()
                    TextField("Title", text: $title)
                        .labeledTF(label: "Title", isEmpty: title == "")
                    ScrollChoice(labelText: $title, choice: SomeConstants.listTitleChoice )
                    TextField("List description", text: $listDescription)
                        .labeledTF(label: "List description", isEmpty: listDescription == "")
                }
                HStack {
                    Text("Favorite")
                    Spacer()
                    Button(action: {isFavorite.toggle()}){Image(systemName: isFavorite ? "star.fill":"star")}
                }
                Toggle(isOn: $isArchived){Text("Archive")}.padding(.trailing)
                DatePicker("Date created", selection: $dateCreated, displayedComponents: .date)
                Button("Save"){
                    Save()
                }
                .disabled(disableSave)
                .buttonStyle(PrimaryButtonStyle())
            }
        }
        .padding()
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("")
            }
            ToolbarItem(placement: .confirmationAction){
                Button("Save", action: Save)
                    .disabled(disableSave)
            }
        }
    }
    
    private func Save() -> Void {
        // TODO Add message to confirm overwriting changes
        guard title != "" else { return }
        
        if let list = list {
            savelist(list)
        }else {
            let newlist = PatientsList(context: viewContext)
            savelist(newlist)
        }
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func savelist( _ list: PatientsList){
        list.title = self.title
        list.listDescription = self.listDescription
        list.dateCreated = self.dateCreated
        list.isFavorite = self.isFavorite
        list.isArchived = self.isArchived
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
}

struct ListFormView_Previews: PreviewProvider {
    static var previews: some View {
        ListFormView()
    }
}
