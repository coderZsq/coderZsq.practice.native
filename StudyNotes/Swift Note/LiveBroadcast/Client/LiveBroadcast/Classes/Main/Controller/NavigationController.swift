//
//  NavigationController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        var count: UInt32 = 0
//        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
//        for i in 0..<count {
//            let nameP = ivar_getName(ivars[Int(i)])!
//            let name = String(cString: nameP)
//            print(name)
//        }
        guard
            let targets = interactivePopGestureRecognizer!.value(forKey: "_targets") as? [NSObject],
            let targetObjc = targets.first,
            let target = targetObjc.value(forKey: "target")
        else { return }
        let action = Selector(("handleNavigationTransition:"))
        let panGes = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGes)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }
}
