//
//  Button modifiers.swift
//  Kreboot (iOS)
//
//  Created by quarticAIMBP2018 on 2021-02-05.
//

import SwiftUI

struct SettingsButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .background(Color.accentColor)
            .cornerRadius(8)
    }
}

struct OutlineButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color.accentColor)
        )
    }
}

struct TightOutlineButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding(.vertical, 3)
            .padding(.horizontal)
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color.accentColor)
        )
    }
}

struct CapsuleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding(.vertical, 3)
            .padding(.horizontal)
            .background(Capsule().fill(configuration.isPressed ? Color.gray : Color.accentColor))
    }
}

struct OutlineCapsuleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding(.vertical, 3)
            .padding(.horizontal)
            .background(Capsule().stroke(Color.accentColor))
    }
}

struct CircularButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding()
            .background(Circle().fill(configuration.isPressed ? Color.gray : Color.accentColor))
            .shadow(radius: 5)
    }
}

