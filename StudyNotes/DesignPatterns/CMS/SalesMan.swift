//
//  SalesMan.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

protocol SalesManInterface {
    var saleAmount: Float? {set get}
    var rate: Float? {set get}
}

class SalesMan: Employee, SalesManInterface {

    var saleAmount: Float?
    var rate: Float?
    
    override func two_stage_init() {
        rate = 0.04
        Employee.startNumber += 1
        num = Employee.startNumber
        level = 1
        print("请输入销售员的姓名: ", terminator: "")
        name = scanf()
        print("请输入本月的销售额: ", terminator: "")
        saleAmount = Float(scanf())
    }
    
    override func promote() {
        level! += 1
    }
    
    override func calcSalary() {
        salary = Float(saleAmount! * rate!)
    }
    
    override func disInfor() {
        print("姓名: \(name!)")
        print("工号: \(num!)")
        print("级别: \(level!)")
        print("本月的销售额度: \(saleAmount!)")
        print("本月的提成比率: \(rate!)")
        print("本月结算的薪水: \(salary!)")
        print("========================")
    }
}
