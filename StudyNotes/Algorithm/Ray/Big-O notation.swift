//
//  Big-O notation.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct Big_O {
    
    static let array = [1, 2, 3, 4, 5, 6]
    
    static func _1() {
        let value = array[5]
        print(value)
    }
    
    static func _log_n(_ n: Int) {
        var j = 1
        while j < n {
            j *= 2
            print(j)
        }
    }
    
    static func _n(_ n: Int) {
        for i in stride(from: 0, to: n, by: 1) {
            print(array[i])
        }
    }
    
    static func _n_log_n(_ n: Int) {
        if n % 2 == 0 {
            for i in stride(from: 0, to: n, by: 1) {
                var j = 1
                while j < n {
                    j *= 2
                    print(i * j)
                }
            }
        } else {
            for i in stride(from: 0, to: n, by: 1) {
                func index(after i: Int) -> Int? {
                    return i < n ? i * 2 : nil
                }
                for j in sequence(first: 1, next: index(after:)) {
                    print(i * j)
                }
            }
        }
    }
    
    //n^2
    static func _n_2(_ n: Int) {
        for i in stride(from: 0, to: n, by: 1) {
            for j in stride(from: 1, to: n, by: 1) {
                print(i * j)
            }
        }
    }
    
    //n^3
    static func _n_3(_ n: Int) {
        for i in stride(from: 0, to: n, by: 1) {
            for j in stride(from: 1, to: n, by: 1) {
                for k in stride(from: 1, to: n, by: 1) {
                    print(i * j * k)
                }
            }
        }
    }
    
    //2^n
    static func _2_n(_ n: Int, from: String, to: String, spare: String) {
        guard n >= 1 else { return }
        if n > 1 {
            _2_n(n - 1, from: from, to: spare, spare: to)
        } else {
            _2_n(n - 1, from: spare, to: to, spare: from)
        }
    }
    
    //n!
    static func _n_fact(_ n: Int) {
        for i in stride(from: 0, to: n, by: 1) {
            print(i)
            _n_fact(n - 1)
        }
    }
}
