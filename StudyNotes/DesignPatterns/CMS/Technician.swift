//
//  Technician.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Technician: Employee {
    
    var amountHour: Int?
    var moneyPerHour: Int?
    
    override func two_stage_init() {
        Employee.startNumber += 1
        num = Employee.startNumber
        level = 1
        moneyPerHour = 100;
        print("请输入技术人员的姓名: ", terminator: "")
        name = scanf()
        print("请输入本月工作的小时数: ", terminator: "")
        amountHour = Int(scanf())
    }
    
    override func promote() {
        level! += 3
    }
    
    override func calcSalary() {
        salary = Float(amountHour! * moneyPerHour!)
    }
    
    override func disInfor() {
        print("姓名: \(name!)")
        print("工号: \(num!)")
        print("级别: \(level!)")
        print("本月工作的小时数: \(amountHour!)")
        print("每个工作时的薪水: \(moneyPerHour!)")
        print("本月结算的薪水: \(salary!)")
        print("========================")
    }
}
