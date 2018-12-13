//
//  ClientManager.swift
//  LiveBroadcastServer
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Cocoa

protocol ClientManagerDelegate: class {
    func sendMsgToClient(_ data: Data)
}

class ClientManager {
    
    var tcpClient: TCPClient
    weak var delegate: ClientManagerDelegate?
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
                let headData = Data(bytes: lengthMsg, count: 4)
                var length: UInt8 = 0
                headData.copyBytes(to: &length, count: 4)
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
//                switch type {
//                case 0, 1:
//                    let user = try! UserInfo.parseFrom(data: data)
//                    print(user.name)
//                    print(user.level)
//                default:
//                    print("未知类型")
//                }
                let totalData = headData + typeData + data
                delegate?.sendMsgToClient(totalData)
            } else {
                isClientConnected = false
                print("客户端断开连接")
            }
        }
    }
    
}
