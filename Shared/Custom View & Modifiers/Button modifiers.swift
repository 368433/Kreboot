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
    var vTightness: PaddingTightness = .normal
    var hTightness: PaddingTightness = .normal
    var bgColor: Color = .accentColor
    var textColor: Color = .white
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(textColor)
            .padding(.vertical, vTightness.space)
            .padding(.horizontal, hTightness.space)
            .background(Capsule().fill(configuration.isPressed ? Color.gray : bgColor))
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
    var tightness: PaddingTightness = .normal
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding(.all, tightness.space)
            .background(Circle().fill(configuration.isPressed ? Color.gray : Color.accentColor))
            .shadow(radius: 5)
    }
}

struct TagButtonStyle: ButtonStyle {
    private var bgColor: Color = .yellow
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .padding(6)
            .background(configuration.isPressed ? bgColor.opacity(0.5) : bgColor)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
            .foregroundColor(.white)
            .clipShape(Rectangle())
            .cornerRadius(5)
    }
}


