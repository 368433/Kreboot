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
    
    var body: some View {
        List {
            ForEach(patients) { pt in
                NavigationLink(destination: PatientFormView(patient: pt)){
                    PatientRowView(patient: pt)
                }
            }
            .onDelete(perform: deleteItems)
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
                    
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newPatient = Patient(context: viewContext)
            newPatient.name = "boby" + String(Int.random(in: 0..<20))
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { patients[$0] }.forEach(viewContext.delete)
            
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
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PatientsDBView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

//struct ContentView_Previews_2: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
