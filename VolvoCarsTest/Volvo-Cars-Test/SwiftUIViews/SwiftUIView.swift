//
//  SwiftUIView.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import SwiftUI

struct SwiftUIView: View {
    @StateObject private var vm = HomeViewModel()

    var body: some View {
        ZStack {
            HomeView()
                .task {
                    await vm.getCastsWith(adcodes: vm.defaultAdcodes)
                }
                .environmentObject(vm)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
