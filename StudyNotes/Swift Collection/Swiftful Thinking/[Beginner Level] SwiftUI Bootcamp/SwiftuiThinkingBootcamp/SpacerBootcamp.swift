//
//  SpacerBootcamp.swift
//  SwiftuiThinkingBootcamp
//
//  Created by 朱双泉 on 2022/12/30.
//

import SwiftUI

struct SpacerBootcamp: View {
    var body: some View {
//        HStack(spacing: 0) {
//            Spacer(minLength: 0)
//                .frame(height: 10)
//                .background(Color.orange)
//
//            Rectangle()
//                .frame(width: 50, height: 50)
//
//            Spacer()
//                .frame(height: 10)
//                .background(Color.orange)
//
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: 50, height: 50)
//
//            Spacer()
//                .frame(height: 10)
//                .background(Color.orange)
//
//            Rectangle()
//                .fill(Color.green)
//                .frame(width: 50, height: 50)
//
//            Spacer(minLength: 0)
//                .frame(height: 10)
//                .background(Color.orange)
//        }
//        .background(Color.yellow)
//        //.padding(.horizontal, 200)
//        .background(Color.blue)
        
        VStack {
            HStack(spacing: 0) {
                Image(systemName: "xmark")
                Spacer()
                    //.frame(height: 10)
                    //.background(Color.orange)
                
                Image(systemName: "gear")
            }
            .font(.title)
            //.background(Color.yellow)
            .padding(.horizontal)
            //.background(Color.blue)
            
            Spacer()
                //.frame(width: 10)
                //.background(Color.orange)
            
            Rectangle()
                .frame(height: 55)
        }
        //.background(Color.yellow)
    }
}

struct SpacerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SpacerBootcamp()
    }
}
