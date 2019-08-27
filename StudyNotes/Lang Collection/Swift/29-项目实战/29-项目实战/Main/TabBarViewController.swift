//
//  TabBarViewController.swift
//  29-项目实战
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setValue(TabBar(), forKey: "tabBar")
        tabBar.barTintColor = .white
        
        addChild("Home", "", "", HomeViewController.self)
        addChild("Trend", "", "", TrendViewController.self)
        addChild("Live", "", "", LiveViewController.self)
    }
    
    func addChild(_ title: String,
                  _ image: String,
                  _ selectedImage: String,
                  _ type: UIViewController.Type) {
        let child = UINavigationController(rootViewController: type.init())
        child.title = title
        child.tabBarItem.image = UIImage(named: image)
        child.tabBarItem.selectedImage = UIImage(named: selectedImage)
        child.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .selected)
        addChild(child)
    }

}
