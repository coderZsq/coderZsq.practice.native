//
//  ClientManager.swift
//  LiveBroadcastServer
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Cocoa

class ClientManager {
    
    var tcpClient: TCPClient
    fileprivate var isClientConnected = false
    
    init(tcpClient: TCPClient) {
        self.tcpClient = tcpClient
    }
    
}

extension ClientManager {
    
    func startReadMessage() {
        isClientConnected = true
        while isClientConnected {
            if let lengthMsg = tcpClient.read(4) {
                let msgData = Data(bytes: lengthMsg, count: 4)
                var length: UInt8 = 0
                msgData.copyBytes(to: &length, count: 4)
                guard let typeMsg = tcpClient.read(2) else {
                    return
                }
                let typeData = Data(bytes: typeMsg, count: 2)
                var type: UInt8 = 0
                typeData.copyBytes(to: &type, count: 2)
                guard let msg = tcpClient.read(Int(length)) else {
                    return
                }
                let data = Data(bytes: msg, count: Int(length))
                let string = String(data: data, encoding: .utf8)
            } else {
                isClientConnected = false
                print("客户端断开连接")
            }
        }
    }
    
}
