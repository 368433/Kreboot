//
//  WorklistCardView.swift
//  Kreboot
//
//  Created by Amir Mac Pro 2019 on 2021-02-24.
//

import SwiftUI

struct WorklistCardView: View {
    var bottomText: String = "worklist to get to see"
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            Color.Midnightblue
            Text(bottomText.capitalized)
                .foregroundColor(.white)
                .font(.title3)
                .fontWeight(.bold)
                .multilineTextAlignment(.trailing)
                .padding()
        }.frame(width: 200, height: 300).cornerRadius(15).shadow(radius: 10).overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 4)).padding()
    }
}

struct WorklistCardView_Previews: PreviewProvider {
    static var previews: some View {
        WorklistCardView()
    }
}
