//
//  TabBarItem.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by 朱双泉 on 2023/5/19.
//

import Foundation
import SwiftUI

//struct TabBarItem: Hashable {
//    let iconName: String
//    let title: String
//    let color: Color
//}

enum TabBarItem: Hashable {
    case home, favorite, profile, messages
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .favorite: return "heart"
        case .profile: return "person"
        case .messages: return "message"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorite: return "Favorites"
        case .profile: return "Profile"
        case .messages: return "Messages"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return Color.red
        case .favorite: return Color.blue
        case .profile: return Color.green
        case .messages: return Color.orange
        }
    }
}
