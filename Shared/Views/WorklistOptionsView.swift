//
//  WorklistOptionsView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-27.
//

import SwiftUI

struct WorklistOptionsView: View {
    @ObservedObject var model: WorklistViewModel
    
    var body: some View {
        VStack{
            Spacer()
            if model.editRoom {
                NewRoomView(worklistModel: model)
                    .transition(.move(edge: .bottom))
            }
            
            if model.showFilter {
                FilterAndSortPickerView(
                    startingFilter: model.cardsFilter,
                    startingSort: model.cardsSort,
                    filterFunc: {filter in model.cardsFilter = filter},
                    sortFunc: {sort in model.cardsSort = sort}
                ).transition(.move(edge: .bottom))
            }
        }
    }
}

//struct WorklistOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorklistOptionsView()
//    }
//}
