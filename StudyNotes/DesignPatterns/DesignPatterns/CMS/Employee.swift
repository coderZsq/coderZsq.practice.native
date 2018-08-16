//
//  Employee.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Employee {
    
    var name: String?
    var num: Int?
    var level: Int?
    var salary: Float?
    static var startNumber: Int = 1000
    
    func two_stage_init() {}
    func promote() {}
    func calcSalary() {}
    func disInfor() {}
}
