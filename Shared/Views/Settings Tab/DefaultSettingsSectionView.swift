//
//  DefaultSettingsSectionView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-25.
//

import SwiftUI

struct DefaultSettingsSectionView: View {
    @ObservedObject var settingsModel: SettingsViewModel
    
    var body: some View {
        Toggle("Show Last list on appear", isOn: $settingsModel.showLastList).onReceive(settingsModel.$showLastList){ show in
            settingsModel.setShowLastList()
        }
    }
}
