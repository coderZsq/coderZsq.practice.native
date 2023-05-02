//
//  SwiftUIViewFactory.swift
//  Volvo-Cars-Test
//
//  Created by 朱双泉 on 2023/4/25.
//

import Foundation
import SwiftUI

class SwiftUIViewWrapper : NSObject {
    
    @objc static func createSwiftUIView() -> UIViewController {
        return UIHostingController(rootView: SwiftUIView())
    }
}
