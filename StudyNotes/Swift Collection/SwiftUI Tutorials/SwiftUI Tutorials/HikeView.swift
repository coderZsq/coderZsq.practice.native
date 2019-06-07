//
//  HikeView.swift
//  SwiftUI Tutorials
//
//  Created by 朱双泉 on 2019/6/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

import SwiftUI

struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false
    
    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)
                    .animation(nil)
                
                VStack(alignment: .leading) {
                    Text(verbatim: hike.name)
                        .font(.headline)
                    Text(verbatim: hike.distanceText)
                }
                
                Spacer()
                
                Button(action: {
                    self.showDetail.toggle()
                }) {
                    Image(systemName: "chevron.right.circle")
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
            }
            
            if showDetail {
                HikeDetail(hike: hike)
            }
        }
    }
}

#if DEBUG
struct HikeView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HikeView(hike: hikeData[0])
                .padding()
            Spacer()
        }
    }
}
#endif
