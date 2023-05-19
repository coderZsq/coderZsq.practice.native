//
//  AppTabBarView.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by 朱双泉 on 2023/5/18.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchedGeometryEffect

struct AppTabBarView: View {
    
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home
    
    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
            
            Color.orange
                .tabBarItem(tab: .messages, selection: $tabSelection)
            
            Color.blue
                .tabBarItem(tab: .home, selection: $tabSelection)

            Color.red
                .tabBarItem(tab: .favorite, selection: $tabSelection)
        }
    }
}

struct AppTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabBarView()
    }
}

extension AppTabBarView {
    
    private var defaultTabView: some View { 
        TabView(selection: $selection) {
            Color.red
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Color.blue
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
            Color.orange
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}
