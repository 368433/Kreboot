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
        ZStack{
//            VStack{
//                Spacer()
                if model.editRoom {
                    VisualEffectBlur(blurStyle: .systemMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            model.hideRoomEdit()
                        }
                    NewRoomView(worklistModel: model).padding()
                }
                
                if model.showFilter {
                    VisualEffectBlur(blurStyle: .systemMaterial)
                        //.ignoresSafeArea()
                        .onTapGesture {
                            model.showFilter.toggle()
                        }
                    FilterAndSortPickerView(
                        startingFilter: model.cardsFilter,
                        startingSort: model.cardsSort,
                        filterFunc: {filter in model.cardsFilter = filter},
                        sortFunc: {sort in model.cardsSort = sort}
                    ).padding()
                }
//            }
        }
    }
}

//struct WorklistOptionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorklistOptionsView()
//    }
//}
