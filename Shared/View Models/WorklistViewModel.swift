//
//  WorklistViewModel.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-12.
//

import SwiftUI
import Combine

class WorklistViewModel: ObservableObject {
    @Published var list: PatientsList?
    
    @Published var selectedCard: Patient? = nil
    @Published var selectedAct: Act? = nil
    @Published var selectedEpisode: MedicalEpisode? = nil
    
    @Published var activeSheet: ActiveSheet? = nil
    @Published var hideActionButton: Bool = false
    
    @Published var cardsFilter: CardsFilter = .seen
    @Published var cardsSort: MedicalEpisodeSort = .name
    @Published var episodesList: [MedicalEpisode] = []

    private var cancellables = Set<AnyCancellable>()
    private var cardsFilterPublisher: AnyPublisher<[MedicalEpisode],Never> {
        $cardsFilter
            .map{ filter in
                if let list = self.list, let episodesSet = list.medicalEpisodes, let episodes = Array(episodesSet) as? [MedicalEpisode] {
                    switch filter {
                    case .all:
                        return episodes
                    case .toSee:
                        return episodes.filter {$0.patient?.name?.contains("Bob") ?? false}
                    case .discharged:
                        return []
                    case .seen:
                        return []
                    }
                }
                return []
            }
            .eraseToAnyPublisher()
    }
    
//    public var cardsSortPublisher: AnyPublisher<NSSortDescriptor ,Never> {
//
//    }

    var isEmpty: Bool { return list == nil }
    var listTitle: String { return list?.title ?? "Untiltled list"}
    
    
    init(patientsList list: PatientsList? = nil){
        self.list = list
        episodesList = filterEpisodes()
        $list
            .map{$0?.uniqueID?.uuidString}
            .sink{ uniqueID in
                UserDefaults.standard.set(uniqueID, forKey: "lastListSelected")
            }
            .store(in: &cancellables)
        
        cardsFilterPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.episodesList, on: self)
            .store(in: &cancellables)
    }
    
//
//
//    var medicalEpisodes: [MedicalEpisode] {
//        //TODO: convert to function and add a predicate and sorting option
//        guard let list = list else {return []}
//        let episodes = list.medicalEpisodes as? Set<MedicalEpisode> ?? []
//        return Array(episodes)
//    }
    
    private func filterEpisodes() -> [MedicalEpisode] {
        guard let list = list else {return []}
        guard let episodesSet = list.medicalEpisodes else {return []}
        guard let episodes = Array(episodesSet) as? [MedicalEpisode] else {return []}
        switch self.cardsFilter {
        case .all:
            return episodes
        case .toSee:
            return episodes.filter {$0.patient?.name?.contains("Bob") ?? false}
        case .discharged:
            return []
        case .seen:
            return []
        }
    }
    
    func medicalEpisodes(sortedBy episodeFilters: [MedicalEpisodeSort], _ ascending: Bool) -> [MedicalEpisode] {
        //TODO: convert to function and add a predicate and sorting option
        guard let list = list else {return []}
        guard let episode = list.medicalEpisodes else {return []}
        // CAN CATCH ERROR HERE IF SORTDESCRIPTORS DO NOT FIT MEDICAL EPISODE
        return episode.sortedArray(using: episodeFilters.map{$0.descriptor(ascending)}) as? [MedicalEpisode] ?? []
    }
    
//
//    var patientsList: [Patient] {
//        guard let list = list else {return []}
//        return list.patientsArray
//    }
}
