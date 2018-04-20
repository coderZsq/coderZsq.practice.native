//
//  UIApplication.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class UIApplication: UIApplicationProtocol {
   
    static let sharedApplication = AppDelegate()
    
    @discardableResult func run() -> Bool {
        return applicationDidFinishLaunching()
    }
    
    func applicationDidFinishLaunching() -> Bool { return true }
}
