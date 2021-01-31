//
//  KrebootApp.swift
//  Shared
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI

@main
struct KrebootApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView{

                NavigationView{
                    StarredPatientsList()
                }.tabItem { Label("WorkLists", systemImage: "star.fill") }
                
                NavigationView{
                    PatientsListsView()
                }.tabItem { Label("All Lists", systemImage: "doc.text") }
                
                NavigationView{
                    PatientsDBView()
                }.tabItem { Label("ViewTest", systemImage: "eye") }

                NavigationView{
                    PatientFormView()
                }.tabItem { Label("Patient", systemImage: "person") }
                
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
