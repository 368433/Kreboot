//
//  EpisodeFilterEnum.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-08.
//

import Foundation

enum EpisodeFilterEnum: CaseIterable{
    case toSee, seen, discharged, all
    
    var label: String {
        switch self {
        case .all:
            return "All"
        case .toSee:
            return "To See"
        case .seen:
            return "Seen"
        case .discharged:
            return "D/C"
        }
    }
    
    var predicate: NSPredicate? {
        switch self {
        // Demonstrates simpler syntax for predicate buidling
        case .all:
            return nil
        case .toSee:
            return NSPredicate(format: "isArchived = %d", true)
        case .seen:
            return NSPredicate(format: "isFavorite = %d", true)
        case .discharged:
            return NSPredicate(format: "isArchived = %d", false)
        }
    }
    
    var descriptors: [NSSortDescriptor] {
        switch self {
        default:
            return [NSSortDescriptor(keyPath: \PatientsList.title, ascending: true)]
        }
    }
}
