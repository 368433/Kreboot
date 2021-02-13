//
//  BillingView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-01-31.
//

import SwiftUI

struct BillingView: View {
    @GestureState private var dragOffset = CGSize.zero

    var body: some View {
        ScrollView {
            Image(systemName: "star.circle.fill")
                .font(.system(size: 100))
                .offset(x: dragOffset.width, y: dragOffset.height)
                .animation(.easeInOut)
                .foregroundColor(.green)
        }.gesture(
            DragGesture()
                .updating($dragOffset, body: { (value, state, transaction) in
                    state = value.translation
                })
    )
    }
}

struct BillingView_Previews: PreviewProvider {
    static var previews: some View {
        BillingView()
    }
}
