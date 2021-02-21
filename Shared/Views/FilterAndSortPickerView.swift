//
//  FilterAndSortPickerView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-20.
//

import SwiftUI

struct FilterAndSortPickerView: View {
    var optionSpacing: CGFloat = 10
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                VStack{
                    LabelSubsection("filter")
                    Divider()
                    HStack(spacing: optionSpacing){
                        ForEach(EpisodeFilterEnum.allCases, id:\.self){filter in
                            Button(action: {}){Text(filter.label)}
                        }
                    }
                }
                VStack{
                    LabelSubsection("sort")
                    Divider()
                    HStack(spacing: optionSpacing){
                        ForEach(EpisodeFilterEnum.allCases, id:\.self){filter in
                            Button(action: {}){LabelSubsection(filter.label)}
                        }
                    }
                }
            }
        }
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
        FilterAndSortPickerView()
    }
}
