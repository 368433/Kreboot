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
    var tightness: Tightness = .normal
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

enum Tightness {
    case tight, normal, large
    var space : CGFloat?{
        switch self {
        case .tight:
            return 8
        case .normal:
            return nil
        case .large:
            return 25
        }
    }
}