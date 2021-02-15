//
//  ActListViewModel.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-15.
//

import Combine
import SwiftUI

class ActListViewModel: ObservableObject {
    @Published var actList: [Act] = []
    @Published var episode: MedicalEpisode?
    
    private let viewContext = PersistenceController.shared.container.viewContext
    private var cancellables = Set<AnyCancellable>()
    private var changeActsPublisher: AnyPublisher<[Act], Never> {
        $episode
            .map{ episode in guard let actSet = episode?.acts as? Set<Act> else {return []}
                return actSet.sorted(by: {
                    guard let time0 = $0.timestamp else {return true}
                    guard let time1 = $1.timestamp else {return true}
                    return time0 > time1
                })
            }
            .eraseToAnyPublisher()
    }
    
    init(episode: MedicalEpisode?){
        self.episode = episode
        changeActsPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.actList, on: self)
            .store(in: &cancellables)
    }
    
    func delete(act: Act) {
        withAnimation {
            viewContext.perform {
                self.viewContext.delete(act)
                do {
                    try self.viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet){
        let viewContext = PersistenceController.shared.container.viewContext
        withAnimation {
            viewContext.perform{
                offsets.map { self.actList[$0] }.forEach(viewContext.delete)
                
                do {
                    try viewContext.save()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }

}
