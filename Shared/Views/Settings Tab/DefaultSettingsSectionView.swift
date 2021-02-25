//
//  DefaultSettingsSectionView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-25.
//

import SwiftUI

struct DefaultSettingsSectionView: View {
    @State private var lastListShown: Bool = false {
        didSet{
            print("action")
        }
    }
    
    var body: some View {
        Toggle("Show Last list on appear", isOn: $lastListShown).onTapGesture {
            print("test")
        }
    }
}

struct DefaultSettingsSectionView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultSettingsSectionView()
    }
}
