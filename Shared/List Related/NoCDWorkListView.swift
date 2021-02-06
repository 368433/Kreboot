//
//  NoCDWorkListView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-06.
//

import SwiftUI
import CoreData

class DataSource1: ObservableObject {
    @Published var patientsLists: Collection
    @Environment(\.managedObjectContext) var viewContext
    
    init(predicate: NSPredicate, sort: [NSSortDescriptor]){
        let request = FetchRequest<PatientsList>(entity: PatientsList.entity(), sortDescriptors: sort, predicate: predicate, animation: nil)
        patientsLists = request
    }
}

struct ptList1: View {
    @StateObject var source = DataSource1()
    var body: some View{
        List(source.patientsLists, id:\.self) { list in
            ListRow(list: list)
        }
    }
}

struct NoCDWorkListView: View {
    
    var body: some View {
        ptList1()
    }
}

struct NoCDWorkListView_Previews: PreviewProvider {
    static var previews: some View {
        NoCDWorkListView()
    }
}
