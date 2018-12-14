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
    func removeClient(_ client: ClientManager)
}

class ClientManager: NSObject {
    
    var tcpClient: TCPClient
    weak var delegate: ClientManagerDelegate?
    fileprivate var isReceiveHeartBeat = false
    fileprivate var isClientConnected = false
    
    init(tcpClient: TCPClient) {
        self.tcpClient = tcpClient
    }
    
}

extension ClientManager {
    
    func startReadMessage() {
        isClientConnected = true
        let timer = Timer(fireAt: Date(timeIntervalSinceNow: 10), interval: 10, target: self, selector: #selector(checkHeartbeat), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .default)
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
                if type == 1 {
                    tcpClient.close()
                    delegate?.removeClient(self)
                } else if type == 100 {
                    isReceiveHeartBeat = true
                    continue
                }
                guard let msg = tcpClient.read(Int(length)) else {
                    return
                }
                let data = Data(bytes: msg, count: Int(length))
                switch type {
                case 0, 1:
                    let user = try! UserInfo.parseFrom(data: data)
                    print(user.name)
                    print(user.level)
                case 2:
                    let textMsg = try! TextMessage.parseFrom(data: data)
                    print(textMsg.text)
                case 3:
                    let giftMsg = try! GiftMessage.parseFrom(data: data)
                    print(giftMsg.giftname)
                    print(giftMsg.gitUrl)
                    print(giftMsg.giftCount)
                default:
                    print("未知类型")
                }
                let totalData = headData + typeData + data
                delegate?.sendMsgToClient(totalData)
            } else {
                delegate?.removeClient(self)
                isClientConnected = false
                tcpClient.close()
                print("客户端断开连接")
            }
        }
    }
    
    @objc fileprivate func checkHeartbeat() {
        if !isReceiveHeartBeat {
            tcpClient.close()
            delegate?.removeClient(self)
        } else {
            isReceiveHeartBeat = false
        }
    }
    
}
