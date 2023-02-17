//
//  IconsBootcamp.swift
//  SwiftuiThinkingBootcamp
//
//  Created by 朱双泉 on 2022/12/17.
//
//  MARK: https://devimages-cdn.apple.com/design/resources/download/SF-Symbols-4.dmg

import SwiftUI

///
struct IconsBootcamp: View {
    var body: some View {
        Image(systemName: "person.fill.badge.plus")
            .renderingMode(.original)
            .font(.largeTitle)
            //.resizable()
            //.aspectRatio(contentMode: .fit)
            //.scaledToFit()
            .scaledToFill()
            //.font(.caption)
            //.font(.system(size: 200))
            //.foregroundColor(.red)
            //.frame(width: 300, height: 300)
            //.clipped()
    }
}

struct IconsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        IconsBootcamp()
    }
}
