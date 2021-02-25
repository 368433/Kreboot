//
//  ICDSettings.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

struct DatabasesSettingsView: View {
    @ObservedObject private var idcDataProvider = ICDCodesProvider3()
    
    var body: some View {
        HStack{
            Text("ICD database")
            Spacer()
            Button(action: loadICDData){Image(systemName: "arrow.clockwise")}
            Button(action: deleteICDData){Image(systemName: "trash")}.padding(.leading)
        }
        HStack{
            Text("Physicians database")
            Spacer()
            Button(action: {}){Text("Implement")}
        }
        HStack{
            Text("Internal database Check")
            Spacer()
            Button(action: {}){Text("Implement")}
            /**Ensure no nil UUID. Attach unassigned Episodes to UnassignedList*/
        }
    }
    
    private func loadICDData(){
        idcDataProvider.fetchICDCodes { (error) in
            DispatchQueue.main.async {
                handleBatchOperationCompletion(error: error)
            }
        }
    }
    private func handleBatchOperationCompletion(error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            idcDataProvider.resetAndRefetch()
        }
    }
    private func deleteICDData() {
        idcDataProvider.deleteAll { (error) in
            DispatchQueue.main.async {
                handleBatchOperationCompletion(error: error)
            }
        }
    }
}


struct ICDSettings_Previews: PreviewProvider {
    static var previews: some View {
        DatabasesSettingsView()
    }
}
