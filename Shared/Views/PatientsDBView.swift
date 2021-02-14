//
//  ContentView.swift
//  Shared
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI
import CoreData

struct PatientsDBView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Patient.name, ascending: true)], animation: .default)
    private var patients: FetchedResults<Patient>
    
    @State private var showForm: Bool = false
    

    var body: some View {
        VStack (alignment:.leading){
            List {
                ForEach(patients) { pt in
                    NavigationLink(destination: PatientFormView(patient: pt, newEpisode: false)){
                        PatientRowView(patient: pt)
                    }
                }.onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .principal){
                    Text("Patients").font(.largeTitle).fontWeight(.bold)
                }
                ToolbarItem(placement: .primaryAction){
                    HStack{
                        #if os(iOS)
                        EditButton()
                        #endif

                        Button(action: {showForm.toggle()}) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showForm, content: {
            PatientFormView(newEpisode: false)
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { patients[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsDBView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
