//
//  ICDListView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
//

import SwiftUI
import Combine

struct ICDListView: View {
    @ObservedObject var delay = DelayedSearch()
//    @State private var searchTerm = ""

//    private var predicate: NSPredicate? {
//        return NSPredicate(format: "icd10Description CONTAINS[cd] %@", delay.searchTerm)
//    }


    var body: some View {
        VStack{
            SearchBar(text: $delay.searchTerm).padding()
            List{
                CoreDataProvider(sorting: [NSSortDescriptor(keyPath: \ICD10dx.icd10Code, ascending: true)], predicate: NSPredicate(format: "icd10Description CONTAINS[cd] %@", delay.searchTerm)) { (icd: ICD10dx) in
                    VStack (alignment: .leading){
                        Text(icd.wrappedCode)
                        Text(icd.wrappedDescription)
                    }
                }
            }
        }
    }
}

class DelayedSearch: ObservableObject {
    @Published var searchTerm: String = ""
    
    var updatedSearchTerm: AnyPublisher<String?, Never> {
        return $searchTerm
            .throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
            .removeDuplicates()
            .flatMap { term in
                return Future { promise in
                    promise(.success(term))
                }
            }
            .eraseToAnyPublisher()
    }
}

struct ICDListView_Previews: PreviewProvider {
    static var previews: some View {
        ICDListView()
    }
}
