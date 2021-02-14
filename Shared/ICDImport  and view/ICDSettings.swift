//
//  ICDSettings.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

struct ICDSettings: View {
    @ObservedObject private var idcDataProvider = ICDCodesProvider3()
    
    var body: some View {
//        VStack {
            Button(action: loadICDData, label: {
                HStack(alignment: .center, spacing: nil, content: {
                    Text("Reload data")
                    Spacer()
                    Image(systemName: "arrow.clockwise")
                })
            })
            Button(action: deleteICDData, label: {
                HStack {
                    Text("Delete data")
                    Spacer()
                    Image(systemName: "trash")
                }
            })
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

struct ICDSettingsHeader: View {
    var body: some View{
        Text("ICD Codes")
    }
}

struct ICDSettingsFooter: View {
    var body: some View {
        HStack(alignment: .center) {
            Text("ICD: ")
            Divider()
            Text("Imported: ")
            Divider()
            Text("Total codes: ")
        }
    }
}

struct ICDSettings_Previews: PreviewProvider {
    static var previews: some View {
        ICDSettings()
    }
}
