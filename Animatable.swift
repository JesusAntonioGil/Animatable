//
//  Animatable.swift
//  CodeRandom
//
//  Created by Jesus Antonio Gil on 27/1/25.
//

import SwiftUI



struct ViewTransition {
    var size: Double
    var degrees: Double
    var anchor: UnitPoint = .bottomLeading
}


struct TextTransition: Animatable, ViewModifier {
    var textTransition: ViewTransition
    
    var animatableData: ViewTransition {
        get { textTransition }
        set { textTransition = newValue }
    }
    
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: textTransition.size))
            .rotationEffect(.degrees(textTransition.degrees), anchor: textTransition.anchor)
    }
}


extension View {
    func textTransition(_ viewTransition: ViewTransition) -> some View {
        modifier(TextTransition(textTransition: viewTransition))
    }
}



struct AnimatableButton: View {
    @State var textTransition = ViewTransition(size: 20, degrees: 90)
    @State var isOn = false
    
    
    var body: some View {
        Button("Hello World!") {
            isOn.toggle()
            withAnimation(.spring) {
                textTransition = ViewTransition(size: isOn ? 40 : 20, degrees: isOn ? 0 : 90)
            }
        }
        .textTransition(textTransition)
        .buttonStyle(.borderedProminent)
    }
}


#Preview {
    AnimatableButton()
}
