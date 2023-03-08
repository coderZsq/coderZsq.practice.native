//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by 朱双泉 on 2023/2/28.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
