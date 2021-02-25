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
                header: Text("Defaults"),
                content: {DefaultSettingsSectionView()})
            Section(
                header: Text("Sync"),
                content: {
                    Toggle("Sync with iCloud", isOn: $iCloudSynced)
                    Toggle("Sync with Google firebase", isOn: $firebaseSynced)
                })
            Section(
                header: Text("Databases"),
                footer: ICDSettingsFooter().padding(.bottom),
                content: {ICDSettings()})

            Section(
                header: Text("Check Database"),
                footer: Text("Ensure no nil UUID. Attach unassigned Episodes to UnassignedList").padding(.bottom),
                content: {Text("Needs implementation")})
        }
        .navigationBarTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
