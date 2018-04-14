//
//  Tools.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/4/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

public func timing(_ action: () -> ()) {
    let time = NSDate().timeIntervalSince1970
    action()
    print("timing: \(NSDate().timeIntervalSince1970 - time)")
}

public func randomList(_ num: UInt32) -> [Int] {
    var list = [Int]()
    for _ in 0..<num {
        list.append(Int(arc4random() % num) + 1)
    }
    return list;
}

public func randomNum(_ max: UInt32) -> Int {
    return Int(arc4random() % max) + 1
}
