//
//  WorklistViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import SwiftUI
import Combine

class WorklistViewModel: ObservableObject {
    @Published var list: PatientsList? = nil
    @Published var selectedCard: Patient? = nil
    @Published var selectedAct: Act? = nil
    @Published var selectedEpisode: MedicalEpisode? = nil
    @Published var activeSheet: ActiveSheet? = nil
    @Published var hideActionButton: Bool = false
    @Published var cardsFilter: CardsFilter = .toSee
    @Published var episodesList: [MedicalEpisode] = []

    private var cancellables = Set<AnyCancellable>()
    private var cardsFilterPublisher: AnyPublisher<NSPredicate?,Never> {
        $cardsFilter
            .map{ filter in
                switch filter {
                case .all:
                    return nil
                case .toSee:
                    return nil
                default:
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }

    init(){
        $list
            .map{$0?.uniqueID?.uuidString}
            //.compactMap{$0}
            .sink{ uniqueID in
                UserDefaults.standard.set(uniqueID, forKey: "lastListSelected")
            }
            .store(in: &cancellables)
        
        cardsFilterPublisher
            .receive(on: RunLoop.main)
            .map{ predicate -> [MedicalEpisode] in
                guard let list = self.list else {return []}
                guard let episode = list.medicalEpisodes else {return []}
                return []//episode.filtered(using: predicate).sortedArray(using: []) as? [MedicalEpisode] ?? []
            }
            .assign(to: \.episodesList, on: self)
            .store(in: &cancellables)
    }
    
    var isEmpty: Bool {
        return list == nil
    }
    var listTitle: String {
        return list?.title ?? "Untiltled list"
    }
    
    var medicalEpisodes: [MedicalEpisode] {
        //TODO: convert to function and add a predicate and sorting option
        guard let list = list else {return []}
        let episodes = list.medicalEpisodes as? Set<MedicalEpisode> ?? []
        return Array(episodes)
    }
    
    func medicalEpisodes(sortedBy episodeFilters: [MedicalEpisodeSort], _ ascending: Bool) -> [MedicalEpisode] {
        //TODO: convert to function and add a predicate and sorting option
        guard let list = list else {return []}
        guard let episode = list.medicalEpisodes else {return []}
        // CAN CATCH ERROR HERE IF SORTDESCRIPTORS DO NOT FIT MEDICAL EPISODE
        return episode.sortedArray(using: episodeFilters.map{$0.descriptor(ascending)}) as? [MedicalEpisode] ?? []
    }
    
    
    var patientsList: [Patient] {
        guard let list = list else {return []}
        return list.patientsArray
    }
}
