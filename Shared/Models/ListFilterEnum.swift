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
    case active, favorite, all, archived
    
    var label: String {
        switch self {
        case .all:
            return "All"
        case .archived:
            return "Archived"
        case .favorite:
            return "Pinned"
        case .active:
            return "Active"
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
        case .active:
            return NSPredicate(format: "isArchived = %d", false)
        }
    }
    
    var tagColor: Color {
        return Color.yellow
    }
    
    var descriptors: [NSSortDescriptor] {
        switch self {
        default:
            return [NSSortDescriptor(keyPath: \PatientsList.title, ascending: true)]
        }
    }
}
