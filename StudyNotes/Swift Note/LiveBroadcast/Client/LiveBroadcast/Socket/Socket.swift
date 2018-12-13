//
//  Socket.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class Socket: NSObject {
    fileprivate var tcpClient: TCPClient
    init(addr: String, port: Int) {
        tcpClient = TCPClient(addr: addr, port: port)
    }
}

extension Socket {
    
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 5).0
    }
    
    func send(_ message: Data) {
        tcpClient.send(data: message)
    }
    
    func startReadMessage() {
        DispatchQueue.global().async {
            while true {
                guard let lengthMsg = self.tcpClient.read(4) else {
                    return
                }
                let headData = Data(bytes: lengthMsg, count: 4)
                var length: UInt8 = 0
                headData.copyBytes(to: &length, count: 4)
                guard let typeMsg = self.tcpClient.read(2) else {
                    return
                }
                let typeData = Data(bytes: typeMsg, count: 2)
                var type: UInt8 = 0
                typeData.copyBytes(to: &type, count: 2)
                guard let msg = self.tcpClient.read(Int(length)) else {
                    return
                }
                let data = Data(bytes: msg, count: Int(length))
                switch type {
                case 0, 1:
                    let user = try! UserInfo.parseFrom(data: data)
                    print(user.name)
                    print(user.level)
                default:
                    print("未知类型")
                }
            }
        }
    }
    
}
