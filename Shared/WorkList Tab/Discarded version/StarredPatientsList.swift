//
//  StarredPatientsList.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

//import SwiftUI
//
//struct StarredPatientsList: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @Environment(\.presentationMode) var presentationMode
//    
//    @FetchRequest(entity: PatientsList.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \PatientsList.title, ascending: true)], predicate: ListFilterEnum.favorite.predicate, animation: .default)
//    private var lists: FetchedResults<PatientsList>
//    
//    @State private var presentForm: Bool = false
//    
//    var body: some View {
//        List(lists) { list in
//            NavigationLink(destination: PatientListDetailView(list: list)){
//                ListRow(list: list)
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .principal){
//                Text("Worklists").font(.largeTitle).fontWeight(.bold)
//            }
//            ToolbarItem(placement: .primaryAction){
//                Button(action: {presentForm.toggle()}){Image(systemName: "plus")}
//            }
//        }.sheet(isPresented: $presentForm, content: {ListFormView()})
//    }
//}
//
//struct StarredPatientsList_Previews: PreviewProvider {
//    static var previews: some View {
//        StarredPatientsList().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
