//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by 朱双泉 on 2023/2/27.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
