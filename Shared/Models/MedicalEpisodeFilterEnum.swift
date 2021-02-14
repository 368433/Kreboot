//
//  MedicalEpisodeFilterEnum.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-14.
//

import Foundation

enum EpisodeFilter: CaseIterable {
    case name, room, date
    
    func descriptor(_ ascending: Bool) -> NSSortDescriptor {
        switch self {
        case .name:
            return NSSortDescriptor(keyPath: \MedicalEpisode.patient?.name, ascending: ascending)
        case .room:
            return NSSortDescriptor(keyPath: \MedicalEpisode.roomLocation, ascending: ascending)
        case .date:
            return NSSortDescriptor(keyPath: \MedicalEpisode.startDate, ascending: ascending)
        }
    }
}
