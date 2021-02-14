//
//  VerticalLabel.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct VerticalLabel: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack{
            configuration.icon
            configuration.title
        }
    }
}
