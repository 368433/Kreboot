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
    
    init(filterFunc: @escaping (EpisodeFilterEnum) -> Void, sortFunc: @escaping (EpisodeSortEnum) -> Void){
        self.filterFunc = filterFunc
        self.sortFunc = sortFunc
    }
    
    var body: some View {
        VStack{
            HStack{
                LabelSubsection("Filter by: ")
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
                LabelSubsection("Sort by: ")
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

struct LabelSubsection: View {
    var text: String
    init(_ text: String){
        self.text = text
    }
    var body: some View{
        Text(text.uppercased()).fontWeight(.thin).font(.caption)
    }
}


struct FilterAndSortPickerView_Previews: PreviewProvider {
    static var previews: some View {
        FilterAndSortPickerView(filterFunc: {filter in}, sortFunc: {sort in})
    }
}
