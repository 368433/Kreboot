//
//  ScrollChoice.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-13.
//

import SwiftUI

struct ScrollChoice: View {
    @Binding var labelText: String
    var choice: [String]
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(choice, id:\.self) {txt in
                    Button(action: {labelText = txt}, label: {Text(txt)}).buttonStyle(TagButtonStyle())
                }
            }
        }
    }
}
