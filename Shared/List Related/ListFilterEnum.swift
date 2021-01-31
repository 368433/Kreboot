//
//  ListFilterEnum.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import Foundation
import CoreData
import SwiftUI

enum ListFilterEnum: CaseIterable {
    case all, favorite, archived
    
    var label: String {
        switch self {
        case .all:
            return "All"
        case .archived:
            return "Archived"
        case .favorite:
            return "Favorite"
        }
    }
    
    var predicate: NSPredicate? {
        switch self {
        // Demonstrates simpler syntax for predicate buidling
        case .all:
            return nil
        case .archived:
            return NSPredicate(format: "isArchived = %d", true)
        case .favorite:
            return NSPredicate(format: "isFavorite = %d", true)
        }
    }
    
    var descriptors: [NSSortDescriptor] {
        switch self {
        default:
            return [NSSortDescriptor(keyPath: \PatientsList.dateCreated, ascending: true)]
        }
    }
}
