//
//  ViewModifierBootcamp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by 朱双泉 on 2023/3/15.
//

import SwiftUI

struct DefaultButtonViewModifier: ViewModifier {
    
    let backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor )
            .cornerRadius(10)
            .shadow(radius: 10)
    }
}

extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View {
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Hello, world!")
                .font(.headline)
                .withDefaultButtonFormatting(backgroundColor: .orange)
            
            Text("Hello, everyone!")
                .font(.subheadline)
                .withDefaultButtonFormatting()

            Text("Hello!!!")
                .font(.title)
                .withDefaultButtonFormatting(backgroundColor: .red)
        }
    }
}

struct ViewModifierBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootcamp()
    }
}
