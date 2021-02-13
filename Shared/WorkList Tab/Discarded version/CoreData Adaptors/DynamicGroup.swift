//
//  DynamicGroup.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//
//
//import SwiftUI
//import Foundation
//import CoreData
//
//struct DynamicGroup<T: NSManagedObject, Content: View>: View {
//    
//    @Environment(\.managedObjectContext) var moc
//    var fetchRequest: FetchRequest<T>
//    
//    // this is our content closure; we'll call this once for each item in the list
//    let content: (T) -> Content
//    
//    var body: some View {
//        ForEach(fetchRequest.wrappedValue, id: \.self) { filteredObject in
//            self.content(filteredObject)
//        }.onDelete(perform: deleteItem)
//    }
//    
//    init(sorting: [NSSortDescriptor], predicate: NSPredicate?, @ViewBuilder content: @escaping (T) -> Content) {
//        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sorting, predicate: predicate)
//        self.content = content
//    }
//    
//    private func deleteItem(at offsets: IndexSet){
//        for index in offsets {
//            let item = fetchRequest.wrappedValue[index]
//            moc.delete(item)
//        }
//        do {try moc.save()}
//        catch {/*handle the Core Data error */}
//    }
//}
