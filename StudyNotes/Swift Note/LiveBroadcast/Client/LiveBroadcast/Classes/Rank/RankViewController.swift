//
//  RankViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {

    fileprivate lazy var socket = Socket(addr: "0.0.0.0", port: 6666)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if socket.connectServer() {
            print("链接上服务器")
        }
    }

}
