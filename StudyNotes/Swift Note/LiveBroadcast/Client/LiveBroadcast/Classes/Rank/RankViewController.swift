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
            socket.startReadMessage()
        }
    }
    
    @IBAction func d(_ sender: Any) {
        socket.sendGiftMsg(giftName: "火箭", giftURL: "1111", giftCount: 123)
    }
    @IBAction func c(_ sender: Any) {
        socket.sendTextMsg(message: "这个文本信息")
    }
    @IBAction func b(_ sender: Any) {
        socket.sendLeaveRoom()
    }
    @IBAction func a(_ sender: Any) {
        socket.sendJoinRoom()
    }
}
