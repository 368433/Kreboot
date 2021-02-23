//
//  WorklistHeaderView.swift
//  Kreboot
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct WorklistHeaderView: View {
    @ObservedObject var model: WorklistViewModel
    
    init(for model: WorklistViewModel){
        self.model = model
    }
    
    var body: some View{
        VStack (alignment: .center){
            HStack{
                Button(action:{}){Image(systemName:"xmark").font(.title3)}.padding(.bottom, 5)
                Spacer()
            }
            WorklistTitleHeader(model: model)
            WorklistHeaderButtons(model: model)
            
        }.padding(.horizontal)
    }
}


//struct WorklistHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorklistHeaderView(for: WorklistViewModel())
//    }
//}
