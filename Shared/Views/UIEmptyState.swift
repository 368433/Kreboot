//
//  UIEmptyState.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

struct UIEmptyState: View {
    var titleText: String
    var body: some View {
        VStack{
            Spacer()
            Label(titleText, systemImage: "paperplane").font(.title).foregroundColor(.offWhite).labelStyle(VerticalLabel())
                .offset(y: -60)
            Spacer()
        }
    }
}



struct UIEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        UIEmptyState(titleText: "no results")
    }
}
