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

//                NavigationView{
//                    StarredPatientsList()
//                }.tabItem { Label("WorkLists", systemImage: "star.fill") }
                
                NavigationView{
                    PatientsListsView()
                }.tabItem { Label("WorkLists", systemImage: "doc.text") }
                
                NavigationView{
                    PatientsDBView()
                }.tabItem { Label("Patients", systemImage: "person.2.fill") }
                
                NavigationView{
                    AnalyticsView()
                }.tabItem { Label("Analytics", systemImage: "sum") }
                
                NavigationView{
                    Settings()
                }.tabItem { Label("Settings", systemImage: "gear") }

//                NavigationView{
//                    ICDdbTable3()
//                }.tabItem { Label("ICD", systemImage: "bandage") }
                
//                NavigationView{
//                    BillingView()
//                }.tabItem { Label("Billing", systemImage: "latch.2.case") }
                
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
