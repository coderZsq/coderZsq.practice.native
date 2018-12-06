//
//  WatchOSViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/12/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import WatchConnectivity

class WatchOSViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "WatchOS"
    }
    @IBAction func sendWatchOS(_ sender: UIButton) {
        WCSession.default.sendMessage(["iOS" : "send"], replyHandler: { (reply) in
            print(reply)
        }) { (error) in
            print(error)
        }
    }
}


