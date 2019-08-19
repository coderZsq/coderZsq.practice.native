//
//  Car.swift
//  24-从OC到Swift
//
//  Created by 朱双泉 on 2019/8/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

import Foundation

/*
 Swift暴露给OC的类最终继承自NSObject
 
 使用@objc修饰需要暴露给OC的成员
 
 使用@objcMembers修饰类
 代表默认所有成员都会暴露给OC (包括扩展中定义的成员)
 最终是否成功暴露, 还需要考虑成员自身的访问级别
 
 可以通过@objc重命名Swift暴露给OC的符号名(类名, 属性名, 函数名等)
 */

@objc(SQCar)
@objcMembers class Car: NSObject {
    var price: Double
    @objc(name)
    var band: String
    init(price: Double, band: String) {
        self.price = price
        self.band = band
    }
    @objc(drive)
    func run() { print(price, band, "run") }
    static func run() { print("Car run") }
}

extension Car {
    @objc(exec:v2:)
    func test(_ v1: Int, _ v2: Int) { print(price, band, "test") }
}
