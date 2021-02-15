//
//  PaddingTightness+Enum.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-14.
//

import SwiftUI

enum PaddingTightness {
    case tight, normal, medium, large
    var space : CGFloat?{
        switch self {
        case .tight:
            return 8
        case .normal:
            return nil
        case .large:
            return 25
        case .medium:
            return 20
        }
    }
}
