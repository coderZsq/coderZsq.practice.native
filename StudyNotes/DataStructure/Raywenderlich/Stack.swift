//
//  Stack.swift
//  DataStructure
//
//  Created by 朱双泉 on 2018/5/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public struct Stack<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
    public mutating func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}
