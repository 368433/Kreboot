//
//  EmptyContentModifier.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-25.
//

import SwiftUI

struct EmptyContent: ViewModifier {
    var condition: Bool = false
    var systemName: String
    var caption: String
    func body(content: Content) -> some View {
        ZStack{
            content
            if condition{
                VStack{
                    Image(systemName: systemName).font(.largeTitle)
                    Text(caption).font(.title)
                }.foregroundColor(.Lightgray)
            }
        }
    }
}

extension View {
    func emptyContent(if condition: Bool, show systemImage: String, caption: String) -> some View {
        self.modifier(EmptyContent(condition: condition, systemName: systemImage, caption: caption))
    }
}
