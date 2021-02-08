//
//  ICDListView.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-07.
// Combine and delay code adapted from https://medium.com/better-programming/search-bar-and-combine-in-swift-ui-46f37cec5a9f
//

import SwiftUI
import Combine

struct ICDListView: View {
    @ObservedObject var delay = DelayedSearch(initialPredicate: NSPredicate(format: "icd10Description CONTAINS[cd] %@", ""), predicateFormat: "icd10Description CONTAINS[cd] %@")
    
    var body: some View {
        VStack{
            SearchBar(text: $delay.searchTerm).padding()
            List{
                CoreDataProvider(sorting: [NSSortDescriptor(keyPath: \ICD10dx.icd10Code, ascending: true)], predicate: delay.predicate) { (icd: ICD10dx) in
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
    @Published var searchTerm: String = String()
    @Published var predicate: NSPredicate?
    var subscription: Set<AnyCancellable> = []
    var predicateFormat: String
    
    init(initialPredicate: NSPredicate?, predicateFormat: String){
        self.predicate = initialPredicate
        self.predicateFormat = predicateFormat
        $searchTerm
            .debounce(for: .milliseconds(800), scheduler: RunLoop.main)
            .removeDuplicates()
//            .map({ (string) -> String? in
//                if string.count < 1 {
//                    return nil
//                }
//                return string
//            })
            .compactMap { $0 }
            .sink {(_) in
                //
            } receiveValue: { [self] (searchWord) in
                predicate = NSPredicate(format: predicateFormat, searchWord)
            }.store(in: &subscription)
    }
}

struct ICDListView_Previews: PreviewProvider {
    static var previews: some View {
        ICDListView()
    }
}
