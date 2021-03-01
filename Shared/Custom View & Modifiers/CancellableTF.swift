//
//  CancellableTF.swift
//  Kreboot (iOS)
//
//  Created by Amir Mac Pro 2019 on 2021-02-28.
//

import SwiftUI

extension TextField {
    func cancellable(isEditing: Binding<Bool>, text: Binding<String>) -> some View {
        HStack{
            self
//                .overlay(
//                    HStack {
//                        Spacer()
//                        if !text.wrappedValue.isEmpty {
//                            Button(action: {
//                                print("clicked")
//                                isEditing.wrappedValue = false
//                                text.wrappedValue = ""
//
//                            }) {
//                                Image(systemName: "multiply.circle.fill")
//                                    .foregroundColor(.gray)
//                            }
//                        }
//                    }
//                )
            if isEditing.wrappedValue {
                Button(action:{
                    text.wrappedValue = ""
                    isEditing.wrappedValue = false
                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }){Text("Cancel")}
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}
