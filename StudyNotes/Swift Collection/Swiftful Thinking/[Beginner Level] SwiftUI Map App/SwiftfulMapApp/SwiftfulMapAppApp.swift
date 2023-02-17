//
//  SwiftfulMapAppApp.swift
//  SwiftfulMapApp
//
//  Created by 朱双泉 on 2023/1/30.
//

import SwiftUI

@main
struct SwiftfulMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
