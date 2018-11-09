//
//  main.swift
//  DesignPatterns
//
//  Created by 朱双泉 on 2018/4/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

public func scanf() -> String {
    let input = String(data: FileHandle.standardInput.availableData, encoding: String.Encoding.utf8)
    if let str = input {
        let index = str.index(str.endIndex, offsetBy: -1)
        return String(str[..<index])
    }
    return ""
}

scope(of: "Application Entry", execute: false) {
    AppDelegate.sharedApplication.run()
}

scope(of: "Render Tree", execute: false) {
    
    UILabel.create(CGPoint(x: 100, y: 200), CGSize(width: 300, height: 400), "UILabel.text")
    UIImageView.create(CGPoint(x: 100, y: 500), CGSize(width: 300, height: 400), "UIImageView.image")
    UIView.renderTreeList()
}

scope(of: "CMS", execute: true) {
    
    let empArr = [Technician(), SalesMan(), Manager(), SalesManager()]
    for emp in empArr {
        emp.two_stage_init()
        emp.promote()
        emp.calcSalary()
        emp.disInfor()
    }
}
