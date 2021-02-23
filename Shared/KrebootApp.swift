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

    private var lastList: PatientsList?

    init(){
        if let uniqueID = UserDefaults.standard.string(forKey: "lastListSelected") {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PatientsList")
            request.predicate = NSPredicate(format: "uniqueID == %@", uniqueID)
            do {
                lastList = try PersistenceController.shared.container.viewContext.fetch(request).first as? PatientsList
            } catch {
                print(error)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            TabView{
                
                WorklistHomeView(patientsList: lastList)
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
