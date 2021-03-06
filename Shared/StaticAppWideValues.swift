//
//  StaticAppWideValues.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-26.
//

import SwiftUI


extension CGFloat {
    static var strokeLineOpa: CGFloat = 0.4
}

enum Karla {
    static var strokeOpacity: Double = 0.3
    static var shadowOpacity: Double = 0.4
    static var cornerRadius: CGFloat = 10
    static var animationSpeed: Double = 0.1
    static var episodeCardBgColor: Color = Color(UIColor.secondarySystemBackground)
    case bon
}

struct SomeConstants {
    static let listTitleChoice = ["Clin. Externe", "Garde", "Appels", "Micro7", "Autre"]
}
