//
//  ListFormViewModel.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-10.
//

import Foundation
//ViewModel
import SwiftUI
import Combine

class ListFormViewModel: ObservableObject {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    private var list: PatientsList?
    @Published var title: String
    @Published var date: Date
    @Published var listDescription: String
    @Published var isPinned: Bool
    @Published var isArchived: Bool
    @Published var formIsValid: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    private var isTitleValidPublisher: AnyPublisher<Bool, Never> {
        $title
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    init(list: PatientsList? = nil){
        self.list = list
        
        self._title = Published(initialValue: self.list?.title ?? "")
        self._listDescription = Published(initialValue: self.list?.listDescription ?? "")
        self._date = Published(initialValue: self.list?.dateCreated ?? Date())
        self._isPinned = Published(initialValue: self.list?.isFavorite ?? false)
        self._isArchived = Published(initialValue: self.list?.isArchived ?? false)
        self.formIsValid = !(self.list?.title?.isEmpty ?? true)
        
        isTitleValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &cancellables)
    }
    
    func save(){
        func saveDetails(_ list: PatientsList){
            list.isArchived = isArchived
            list.isFavorite = isPinned
            list.title = self.title
            list.listDescription = self.listDescription
            list.dateCreated = self.date
            list.saveYourself(in: viewContext)
        }

        if let list = list {
            saveDetails(list)
        } else {
            let list = PatientsList(context: viewContext)
            saveDetails(list)
        }
        
    }
}
