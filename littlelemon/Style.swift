//
//  Style.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

struct StylePrimaryButton1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(configuration.isPressed ? .white : .black)
            .padding(10)
            .background(configuration.isPressed ? Color.primaryColorVariant1 : Color.primaryColorVariant2)
            .cornerRadius(8)
            .padding(.horizontal)
    }
}

struct StylePrimaryButton2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.primaryColorVariant1 : .white)
            .padding(10)
            .background(configuration.isPressed ? .white : Color.primaryColorVariant1)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primaryColorVariant1, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct ButtonStylePrimaryColorReverse: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .white : Color.primaryColorVariant1)
            .padding(10)
            .background(configuration.isPressed ? Color.primaryColorVariant1 : .white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primaryColorVariant1, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct ButtonToggleStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? .white : Color.primaryColorVariant1)
            .padding(10)
            .background(configuration.isPressed ? Color.primaryColorVariant1 : .white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.primaryColorVariant1, lineWidth: 1)
            )
            .padding(.horizontal)
    }
}

struct MyToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
            }
        }
        .foregroundColor(Color.primaryColorVariant1)
        .padding(5)
        .background {
            if configuration.isOn {
                Color.highlightColorVariant1
            }
        }
        .cornerRadius(8)
    }
}

extension Text {
    func onboardingTextStyle() -> some View {
        self
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(Color.primaryColorVariant1)
            .font(.custom("Karla-Bold", size: 13))
    }
}

extension Font {
    static func displayFont() -> Font {
        return Font.custom("Markazi Text", size: 42).weight(.medium)
    }
    
    static func subTitleFont() -> Font {
        return Font.custom("Markazi Text", size: 32)
    }
    
    static func leadText() -> Font {
        return Font.custom("Karla", size: 16).weight(.medium)
    }
    
    static func regularText() -> Font {
        return Font.custom("Markazi Text", size: 18)
    }
    
    static func sectionTitle() -> Font {
        return Font.custom("Karla", size: 18).weight(.black)
    }
    
    static func sectionCategories() -> Font {
        return Font.custom("Karla", size: 16).weight(.heavy)
    }
    
    static func paragraphText() -> Font {
        return Font.custom("Karla", size: 14)
    }
    
    static func highlightText() -> Font {
        return Font.custom("Karla", size: 14).weight(.medium)
    }
}


