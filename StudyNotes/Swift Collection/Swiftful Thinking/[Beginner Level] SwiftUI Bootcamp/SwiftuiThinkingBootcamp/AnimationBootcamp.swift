//
//  AnimationBootcamp.swift
//  SwiftuiThinkingBootcamp
//
//  Created by 朱双泉 on 2023/1/5.
//

import SwiftUI

struct AnimationBootcamp: View {
    
    @State var isAnimated: Bool = false
    
    var body: some View {
//        VStack {
//            Button("Button") {
//                withAnimation(
////                    Animation.default.delay(2.0)
//                    Animation
//                        .default
////                        .repeatCount(5, autoreverses: false)
//                        .repeatForever(autoreverses: true)
//                ) {
//                    isAnimated.toggle()
//                }
//            }
//            Spacer()
//            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25.0)
//                .fill(isAnimated ? Color.red : Color.green)
//                .frame(
//                    width: isAnimated ? 100 : 300,
//                    height: isAnimated ? 100 : 300)
//                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
//                .offset(y: isAnimated ? 300 : 0)
//            Spacer()
//        }
        
        VStack {
            Button("Button") {
                isAnimated.toggle()
            }
            Spacer()
            RoundedRectangle(cornerRadius: isAnimated ? 50 : 25.0)
                .fill(isAnimated ? Color.red : Color.green)
                .frame(
                    width: isAnimated ? 100 : 300,
                    height: isAnimated ? 100 : 300)
                .rotationEffect(Angle(degrees: isAnimated ? 360 : 0))
                .offset(y: isAnimated ? 300 : 0)
                .animation(Animation
                            .default
                            .repeatForever(autoreverses: true))
            Spacer()
        }
    }
}

struct AnimationBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AnimationBootcamp()
    }
}
