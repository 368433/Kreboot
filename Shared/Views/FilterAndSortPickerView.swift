//
//  FilterAndSortPickerView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-20.
//

import SwiftUI

struct FilterAndSortPickerView: View {
    var optionSpacing: CGFloat = 10
    @State private var selectedFilter: Int?
    @State private var selectedSort: Int?
    
    private var filterFunc: (EpisodeFilterEnum) -> Void
    private var sortFunc: (EpisodeSortEnum) -> Void
    
    init(startingFilter: EpisodeFilterEnum , startingSort: EpisodeSortEnum, filterFunc: @escaping (EpisodeFilterEnum) -> Void, sortFunc: @escaping (EpisodeSortEnum) -> Void){
        self.filterFunc = filterFunc
        self.sortFunc = sortFunc
        self._selectedFilter = State(initialValue: startingFilter.rawValue)
        self._selectedSort = State(initialValue: startingSort.rawValue)
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Filter by: ").fontWeight(.thin).font(.caption)
                ScrollView(.horizontal){
                    HStack(spacing: optionSpacing){
                        ForEach(EpisodeFilterEnum.allCases){filter in
                            LabelOption(filter.label).padding(6).onTapGesture{
                                filterFunc(filter)
                                self.selectedFilter = filter.rawValue
                            }.background(RoundedRectangle(cornerRadius: 6.0).foregroundColor(selectedFilter == filter.rawValue ? Color.yellow:Color.clear))
                        }
                    }
                }
            }
            HStack{
                Text("Sort by: ").fontWeight(.thin).font(.caption)
                ScrollView(.horizontal){
                    HStack(spacing: optionSpacing){
                        ForEach(EpisodeSortEnum.allCases){sort in
                            LabelOption(sort.label).padding(6).onTapGesture{
                                sortFunc(sort)
                                self.selectedSort = sort.rawValue
                            }.background(RoundedRectangle(cornerRadius: 6.0).foregroundColor(selectedSort == sort.rawValue ? Color.green:Color.clear))
                        }
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: Karla.cornerRadius)
                        .foregroundColor(Color(UIColor.tertiarySystemBackground))
                        .shadow(color: Color.gray.opacity(0.6), radius: 10, y: 10))
    }
}

struct LabelOption: View {
    var text: String
    init(_ text: String){
        self.text = text
    }
    var body: some View{
        Text(text.uppercased()).font(.footnote).fontWeight(.bold)
    }
}

struct FilterAndSortPickerView_Previews: PreviewProvider {
    static var previews: some View {
        FilterAndSortPickerView(startingFilter: .toSee, startingSort: .name, filterFunc: {filter in}, sortFunc: {sort in})
    }
}
