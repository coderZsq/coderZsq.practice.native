//
//  TransitionBootcamp.swift
//  SwiftuiThinkingBootcamp
//
//  Created by 朱双泉 on 2023/1/5.
//

import SwiftUI

struct TransitionBootcamp: View {
    
    @State var showView: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack {
                Button("BUTTON") {
                    showView.toggle()
                }
                Spacer()
            }
            
            if (showView) {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: UIScreen.main.bounds.height * 0.5)
                    //.transition(.slide)
                    //.transition(.move(edge: .bottom))
                    //.transition(AnyTransition.opacity.animation(.easeInOut))
                    //.transition(AnyTransition.scale.animation(.easeInOut))
                    .transition(.asymmetric(
                        insertion: .move(edge: .bottom),
                        removal: AnyTransition.opacity.animation(.easeInOut)
                    ))
                    .animation(.easeInOut)
            }
            
//            RoundedRectangle(cornerRadius: 30)
//                .frame(height: UIScreen.main.bounds.height * 0.5)
//                .opacity(showView ? 1.0 : 0.0)
//                .animation(.easeInOut)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TransitionBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TransitionBootcamp()
    }
}
