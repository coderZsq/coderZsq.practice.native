//
//  ViewController.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/10.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

var currentController: ViewController?

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentController = self
    }
}

