//
//  Settings.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

//ViewModel
class SettingsViewModel: ObservableObject {
    @Published var showLastList: Bool = false
    
    init(){
        self .showLastList = UserDefaults.standard.bool(forKey: "showLastList")
    }
    
    func setShowLastList(){
        UserDefaults.standard.set(showLastList, forKey: "showLastList")
    }
}

struct Settings: View {
    @ObservedObject private var model = SettingsViewModel()
    @State private var iCloudSynced: Bool = false
    @State private var firebaseSynced: Bool = false
    
    var body: some View {
        Form {
            Section(
                header: Text("Defaults"),
                content: {DefaultSettingsSectionView(settingsModel: model)})
            Section(
                header: Text("Sync"),
                content: {
                    Toggle("Sync with iCloud", isOn: $iCloudSynced)
                    Toggle("Sync with Google firebase", isOn: $firebaseSynced)
                })
            Section(
                header: Text("Databases"),
                footer: DatabasesSettingsFooter().padding(.bottom),
                content: {DatabasesSettingsView()})
        }
        .navigationBarTitle("Settings")
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
