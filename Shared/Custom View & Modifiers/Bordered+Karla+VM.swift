//
//  Bordered+Karla+VM.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

struct BorderedKarlaV0: ViewModifier {
    var highlightField: Binding<Bool>
    func body(content: Content) -> some View {
        content
            .padding()
            //.background(RoundedRectangle(cornerRadius: 10).foregroundColor(.white))
            .shadow(color: Color.gray.opacity(highlightField.wrappedValue ? Karla.shadowOpacity:0), radius: 5, x: 0, y: 3)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(Karla.strokeOpacity), lineWidth: 0.5))
        
    }
}

struct BorderedKarla: ViewModifier {
    var highlightField: Binding<Bool>
    var textValue: Binding<String>
    
    func body(content: Content) -> some View {
        HStack{
            content
            if !textValue.wrappedValue.isEmpty{
                Button(action:{textValue.wrappedValue = ""}){Image(systemName: "multiply.circle.fill")}
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: Karla.cornerRadius)
                .foregroundColor(Color(UIColor.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: Karla.cornerRadius)
                        .stroke(Color.gray.opacity(Karla.strokeOpacity), lineWidth: 0.8))
                .shadow(color: Color.gray.opacity(highlightField.wrappedValue ? Karla.shadowOpacity:0), radius: 5, x: 0, y: 3)
        )
    }
}

extension View {
    func borderedK(text: Binding<String>, show: Binding<Bool>) -> some View {
        self.modifier(BorderedKarla(highlightField: show, textValue: text))
    }
}
