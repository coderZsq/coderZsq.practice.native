//
//  ImageBootcamp.swift
//  SwiftuiThinkingBootcamp
//
//  Created by 朱双泉 on 2022/12/17.
//

import SwiftUI

struct ImageBootcamp: View {
    var body: some View {
        Image("R7-white")
            //.renderingMode(.template)
            .resizable()
            //.aspectRatio(contentMode: .fit)
            .scaledToFit()
            //.scaledToFill()
            .frame(width: 300, height: 200)
            .foregroundColor(.green)
            //.clipped()
            //.cornerRadius(150)
            //.clipShape(
                //Circle()
                //RoundedRectangle(cornerRadius: 25.0)
                //Ellipse()
            //    Circle()
            //)
    }
}

struct ImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ImageBootcamp()
    }
}
