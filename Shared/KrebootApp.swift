//
//  KrebootApp.swift
//  Shared
//
//  Created by Amir Mac Pro 2019 on 2021-01-30.
//

import SwiftUI
import CoreData

@main
struct KrebootApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView{
                
                WorklistHomeView()
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
                
            }.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
