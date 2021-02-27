//
//  TestView1.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-11.
//

import SwiftUI

struct TestView1: View {
    
    var body: some View {
        ZStack{
            Color.Whitesmoke.rotationEffect(.degrees(5)).shadow(radius: 10).opacity(0.8)
            Color.Whitesmoke.shadow(radius: 10)
        }
        .frame(width: 150, height: 300)
    }
}

struct TestView1_Previews: PreviewProvider {
    static var previews: some View {
        TestView1()
    }
}
