//
//  ICDSettingsFooter.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-14.
//

import SwiftUI

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

struct ICDSettingsFooter_Previews: PreviewProvider {
    static var previews: some View {
        ICDSettingsFooter()
    }
}
