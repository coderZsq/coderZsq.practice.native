//
//  StructAndClass.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/4.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct StructAndClass {
    
    static func run() {
        
        let mutableArray: NSMutableArray = [1, 2, 3]
        for _ in mutableArray {
            mutableArray.removeLastObject()
        }
        
        var mutableArray1 = [1, 2, 3]
        for _ in mutableArray1 {
            mutableArray1.removeLast()
        }
        
        let otherArray = mutableArray
        mutableArray.add(4)
        print(otherArray)
        
        func scanRemainingBytes(scanner: BinaryScanner) {
            while let byte = scanner.scanByte() {
                print(byte)
            }
        }
        
        let scanner = BinaryScanner(data: Data("hi".utf8))
        print(scanRemainingBytes(scanner: scanner))
        #if false
        for _ in 0..<Int.max {
            let newScanner = BinaryScanner(data: Data("hi".utf8))
            DispatchQueue.global().async {
                print(scanRemainingBytes(scanner: newScanner))
            }
            print(scanRemainingBytes(scanner: newScanner))
        }
        #endif
    }
}

class BinaryScanner {
    var position: Int
    let data: Data
    init(data: Data) {
        self.position = 0
        self.data = data
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8? {
        guard position < data.endIndex else {
            return nil
        }
        position += 1
        return data[position - 1]
    }
}
