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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let userInfo = UserInfo.Builder()
        userInfo.name = "Castiel"
        userInfo.level = 20
        let msgData = (try! userInfo.build()).data()
        var length = msgData.count
        let headerData = Data(bytes: &length, count: 4)
        var type = 2
        let typeData = Data(bytes: &type, count: 2)
        let totalData = headerData + typeData + msgData
        socket.send(totalData)
    }
    
}
