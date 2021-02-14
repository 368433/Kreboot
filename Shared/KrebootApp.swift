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
////                    testGen()
//                    PatientsListsView(selectedList: $test)
//                }.tabItem { Label("test", systemImage: "star.fill") }
                
//                NavigationView{
                    WorklistView() //}
                .tabItem { Label("WorkList", systemImage: "doc.text") }

                NavigationView{
                    DataTab()
                }.tabItem { Label("Data", systemImage: "square.stack.3d.up") }

                NavigationView{
                    AnalyticsView()
                }.tabItem { Label("Analytics", systemImage: "sum") }

                NavigationView{
                    BillingView()
                }.tabItem { Label("Billing", systemImage: "latch.2.case") }

                NavigationView{
                    Settings()
                }.tabItem { Label("Settings", systemImage: "gear") }

                NavigationView{
                    ICDdbTable3()
                }.tabItem { Label("ICD", systemImage: "bandage") }
                
                
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
