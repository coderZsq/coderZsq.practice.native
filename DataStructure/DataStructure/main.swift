//
//  main.swift
//  DataStructure
//
//  Created by 朱双泉 on 27/12/2017.
//  Copyright © 2017 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, action: () -> Void) {
    print("\n--- scope of:", description, "---")
    action()
}

scope(of: "queue") {
    
    let p = Queue(queueCapacity: 4)
    let c1 = Customer(name: "zhangsan", age: 20)
    let c2 = Customer(name: "lisi", age: 30)
    let c3 = Customer(name: "wangwu", age: 25)

    p.enQueue(element: c1)
    p.enQueue(element: c2)
    p.enQueue(element: c3)
    
    p.queueTraverse()

    var c4 = NSObject()
    p.deQueue(element: &c4)
    
//    print(c4.printInfo())
    p.queueTraverse()

    
//    let p = Queue(queueCapacity: 4)
//    p.enQueue(element: 10)
//    p.enQueue(element: 12)
//    p.enQueue(element: 16)
//    p.enQueue(element: 18)
//    p.enQueue(element: 20)
//
//    p.queueTraverse()
//
//    var e = 0
//    p.deQueue(element: &e)
//    print("=== \(e)")
//
//    p.deQueue(element: &e)
//    print("=== \(e)")
//
//    p.queueTraverse()
//
//    p.clearQueue()
//    p.queueTraverse()
//
//    p.enQueue(element: 20)
//    p.enQueue(element: 30)
//    p.queueTraverse()

}
