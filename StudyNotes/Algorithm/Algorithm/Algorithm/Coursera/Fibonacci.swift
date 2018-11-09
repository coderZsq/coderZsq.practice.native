//
//  Fibonacci.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func fibRecurs(n: Int) -> Int {
    if n <= 1 {
        return n
    } else {
        return fibRecurs(n: n - 1) + fibRecurs(n: n - 2)
    }
}

func fibList(n: Int) -> Int {
    
    var f = [Int](repeating: 0, count: n + 1)
    f[0] = 0
    if n > 0 {
        f[1] = 1
    }
    if n > 1 {
        for i in 2...n {
            f[i] = f[i - 1] + f[i - 2]
        }
    }
    return f[n]
}
