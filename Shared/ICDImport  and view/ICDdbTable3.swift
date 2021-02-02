//
//  ICDdbTable3.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-01.
//

import SwiftUI
import CoreData

struct ICDdbTable3: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var dataProvider = ICDCodesProvider ()
    @State private var showBusy = true
    
    //    @FetchRequest(entity: ICD10dx.entity(), sortDescriptors: [], predicate: nil, animation: .default)
    //    private var res: FetchedResults<ICD10dx>
    
    var body: some View {
        // put search bar here
        // table
        print(dataProvider.dataResults.count)
        return List(dataProvider.dataResults, rowContent: ICDTableRow.init)
            //        List(res, rowContent: ICDTableRow.init)
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                    // buttons
                    HStack{
                        Button(action: deleteData){Image(systemName: "trash")}
                        Button(action: refreshData){Image(systemName: "arrow.clockwise")}
                    }
                }
            }
    }
    
    private func refreshData(){
        // Use the ICDCodesProvider to fetch icd data. on completion
        // handle general UI updates and error alerts on the main queue.
        dataProvider.fetchICDCodes { (error) in
            DispatchQueue.main.async {
                handleBatchOperationCompletion(error: error)
            }
        }
    }
    
    private func deleteData() {
//        dataProvider.testDelete()
        dataProvider.deleteAll { (error) in
            DispatchQueue.main.async {
//                handleBatchOperationCompletion(error: error)
            }
        }
    }
    
    private func handleBatchOperationCompletion(error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            dataProvider.resetAndRefetch()
        }
    }
    
}

struct ICDTableRow: View {
    var icdResult: ICD10dx
    var body: some View{
        VStack(alignment:.leading){
            Text(icdResult.icd10Code ?? "No code").fontWeight(.bold)
            Text(icdResult.icd10Description ?? "No description")
        }
    }
}

struct ICDdbTable_Previews: PreviewProvider {
    static var previews: some View {
        ICDdbTable()
    }
}
