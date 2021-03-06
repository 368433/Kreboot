//
//  DynamicallyFilteredList.swift
//  KarlaMay
//
//  Created by quarticAIMBP2018 on 2020-05-13.
//  Copyright © 2020 quarticAIMBP2018. All rights reserved.
//
//  Copied from Hackingwithswift Rights to Paul Hudson and adapted

import SwiftUI
import Foundation
import CoreData

struct CoreDataProvider<T: NSManagedObject, Content: View>: View {
    
    //@Environment(\.managedObjectContext) var viewContext
    var fetchRequest: FetchRequest<T>
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        ForEach(fetchRequest.wrappedValue, id: \.self) { filteredObject in
            self.content(filteredObject)
        }.onDelete(perform: deleteItem)
    }
    
    init(sorting: [NSSortDescriptor], predicate: NSPredicate?, @ViewBuilder content:  @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sorting, predicate: predicate)
        self.content = content
    }
    
    private func deleteItem(at offsets: IndexSet){
        let viewContext = PersistenceController.shared.container.viewContext
        withAnimation {
            viewContext.perform{
                offsets.map { fetchRequest.wrappedValue[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}
