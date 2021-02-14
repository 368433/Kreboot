//
//  ICDSettings.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

struct ICDSettings: View {
    var body: some View {
//        VStack {
            Button(action: {}, label: {
                HStack(alignment: .center, spacing: nil, content: {
                    Text("Reload data")
                    Spacer()
                    Image(systemName: "arrow.clockwise")
                })
            })
            Button(action: {}, label: {
                HStack {
                    Text("Delete data")
                    Spacer()
                    Image(systemName: "trash")
                }
            })
//        }.padding(.horizontal)
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
