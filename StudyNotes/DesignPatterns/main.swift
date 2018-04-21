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

scope(of: "Application Entry", execute: false) {
    AppDelegate.sharedApplication.run()
}

scope(of: "Render Tree", execute: true) {

    UILabel.create(CGPoint(x: 100, y: 200), CGSize(width: 300, height: 400), text: "UILabel.text")
    UIImageView.create(CGPoint(x: 100, y: 500), CGSize(width: 300, height: 400), text: "UIImageView.image")
    UIView.renderTreeList()
}

