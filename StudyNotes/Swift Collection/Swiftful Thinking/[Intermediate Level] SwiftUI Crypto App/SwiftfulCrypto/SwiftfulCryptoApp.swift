//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by 朱双泉 on 2023/2/6.
//

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
