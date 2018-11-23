//
//  SalesManager.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class SalesManager: Employee, SalesManInterface, ManagerInterface {
    
    var saleAmount: Float?
    var rate: Float?
    var fixedSalary: Int?

    override func two_stage_init() {
        fixedSalary = 5000
        Employee.startNumber += 1
        num = Employee.startNumber
        level = 1
        rate = 0.05
        print("请输入销售经理的姓名: ", terminator: "")
        name = scanf()
        print("请输入本月的销售额: ", terminator: "")
        saleAmount = Float(scanf())
    }
    
    override func promote() {
        level! += 3
    }
    
    override func calcSalary() {
        salary = Float(fixedSalary!) + saleAmount! * rate!
    }
    
    override func disInfor() {
        print("姓名: \(name!)")
        print("工号: \(num!)")
        print("级别: \(level!)")
        print("本月的固定薪水: \(fixedSalary!)")
        print("本月的销售额度: \(saleAmount!)")
        print("本月的提成比率: \(rate!)")
        print("本月结算的薪水: \(salary!)")
        print("========================")
    }
}
