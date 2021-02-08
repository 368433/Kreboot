//
//  ActiveSheet.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
//

import Foundation

enum ActiveSheet: Identifiable {
    case first, second, third, fourth, fifth, sixth, seventh
    var id: Int {
        hashValue
    }
}
