//
//  FilterAndSortPickerView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-20.
//

import SwiftUI

struct FilterAndSortPickerView: View {
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                
            }
        }
    }
}

struct SubsectionPickerView: View {
    var sectionTitle: String
    var body: some View {
        VStack{
            Text(sectionTitle)
            HStack{
                ForEach(EpisodeFilterEnum.allCases, id:\.self){filter in
                    Text(filter.label)
                }
            }
        }
    }
}

struct SubsectionPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SubsectionPickerView(sectionTitle: "Filter")
    }
}


struct FilterAndSortPickerView_Previews: PreviewProvider {
    static var previews: some View {
        FilterAndSortPickerView()
    }
}
