//
//  Manager.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

protocol ManagerInterface {
    var fixedSalary: Int? {set get}
}

class Manager: Employee {
    
    var fixedSalary: Int?
    
    override func two_stage_init() {
        fixedSalary = 8000
        Employee.startNumber += 1
        num = Employee.startNumber
        level = 1;
        print("请输入经理的姓名: ", terminator: "")
        name = scanf()
    }
    
    override func promote() {
        level! += 4
    }
    
    override func calcSalary() {
        salary = Float(fixedSalary!)
    }
    
    override func disInfor() {
        print("姓名: \(name!)")
        print("工号: \(num!)")
        print("级别: \(level!)")
        print("本月结算的薪水: \(salary!)")
        print("========================")
    }
}
