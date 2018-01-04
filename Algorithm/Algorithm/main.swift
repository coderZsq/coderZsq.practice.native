//
//  main.swift
//  Algorithm
//
//  Created by 朱双泉 on 04/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, action: () -> Void) {
    print("\n--- scope of:", description, "---")
    action()
}

scope(of: "queue") {
    
    let intQ = Queue<Int>(4)
    
    intQ.entry(1)
    intQ.entry(2)
    intQ.entry(3)
    
    intQ.traverse()
    
    print(intQ.depart()!)
    
    intQ.traverse()
    
    print(intQ.depart()!)
    
    intQ.traverse()
   
    intQ.entry(4)
    intQ.entry(5)
    
    intQ.traverse()
    
    print(intQ.depart()!)
    
    intQ.traverse()
    
    let stringQ = Queue<String>(8)
    
    stringQ.entry("one")
    stringQ.entry("two")
    stringQ.entry("three")
    stringQ.entry("four")
    stringQ.entry("five")
    stringQ.entry("six")
    stringQ.entry("seven")
    stringQ.entry("eight")
    stringQ.entry("nine")
    
    stringQ.traverse()
    
    print(stringQ.depart()!)
    print(stringQ.depart()!)
    print(stringQ.depart()!)

    stringQ.entry("ten")
    
    stringQ.traverse()
}
