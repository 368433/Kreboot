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
            TextEditor(text: .constant("Placeholder"))
                //.padding()
        }.padding()
        
    }
}

struct TestView1_Previews: PreviewProvider {
    static var previews: some View {
        TestView1()
    }
}
