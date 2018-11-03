//
//  SensorViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class SensorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: UIDevice.proximityStateDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func change() {
        if UIDevice.current.proximityState {
            print("有物体靠近")
        } else{
            print("有物体离开")
        }
    }
}
