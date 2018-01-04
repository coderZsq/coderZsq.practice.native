//
//  Test.swift
//  DataStructure
//
//  Created by 朱双泉 on 04/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

class Customer: NSObject {
    
    private var m_strName: String
    private var m_iAge: Int
    
    init(name: String = "", age: Int = 0) {
        m_strName = name
        m_iAge = age
    }
    
    func printInfo() {
        print("姓名: \(m_strName)")
        print("年龄: \(m_iAge)")
    }
}
