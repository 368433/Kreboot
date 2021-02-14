//
//  Settings.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

struct Settings: View {
    @State private var iCloudSynced: Bool = false
    @State private var firebaseSynced: Bool = false
    
    var body: some View {
        Form {
            Section(
                header: Text("Sync"),
                footer: Text(" "),
                content: {
                    Toggle("Sync with iCloud", isOn: $iCloudSynced)
                    Toggle("Sync with Google firebase", isOn: $firebaseSynced)
                })
            Section(
                header: ICDSettingsHeader(),
                footer: ICDSettingsFooter(),
                content: {ICDSettings()})
            Section(
                header: Text("Physicians Database"),
                footer: Text("Last updated: "),
                content: {Text("Upload database")})
        }
        .navigationBarTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
