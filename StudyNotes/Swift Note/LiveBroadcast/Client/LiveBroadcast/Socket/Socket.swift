//
//  Socket.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol SocketDelegate: class {
    func socket(_ socket: Socket, joinRoom user: UserInfo)
    func socket(_ socket: Socket, leaveRoom user: UserInfo)
    func socket(_ socket: Socket, textMsg: TextMessage)
    func socket(_ socket: Socket, giftMsg: GiftMessage)
}

class Socket: NSObject {
    weak var delegate: SocketDelegate?
    fileprivate var tcpClient: TCPClient
    fileprivate var userInfo: UserInfo = {
        let userInfo = UserInfo.Builder()
        userInfo.name = "Castiel"
        userInfo.level = 20
        return try! userInfo.build()
    }()
    init(addr: String, port: Int) {
        tcpClient = TCPClient(addr: addr, port: port)
        super.init()
    }
}

extension Socket {
    
    func connectServer() -> Bool {
        return tcpClient.connect(timeout: 5).0
    }
    
    func startReadMessage() {
        DispatchQueue.global().async {
            while true {
                guard let lengthMsg = self.tcpClient.read(4, timeout: 1) else {
                    continue
                }
                let headData = Data(bytes: lengthMsg, count: 4)
                var length: UInt8 = 0
                headData.copyBytes(to: &length, count: 4)
                guard let typeMsg = self.tcpClient.read(2) else {
                    continue
                }
                let typeData = Data(bytes: typeMsg, count: 2)
                var type: UInt8 = 0
                typeData.copyBytes(to: &type, count: 2)
                guard let msg = self.tcpClient.read(Int(length)) else {
                    continue
                }
                let data = Data(bytes: msg, count: Int(length))
                DispatchQueue.main.async {
                    self.handleMsg(type: Int(type), data: data)
                }
            }
        }
    }
    
    fileprivate func handleMsg(type: Int, data: Data) {
        switch type {
        case 0, 1:
            let user = try! UserInfo.parseFrom(data: data)
            type == 0 ? delegate?.socket(self, joinRoom: user) : delegate?.socket(self, leaveRoom: user)
        case 2:
            let textMsg = try! TextMessage.parseFrom(data: data)
            delegate?.socket(self, textMsg: textMsg)
        case 3:
            let giftMsg = try! GiftMessage.parseFrom(data: data)
            delegate?.socket(self, giftMsg: giftMsg)
        default:
            print("未知类型")
        }
    }
    
}

extension Socket {
    
    func sendJoinRoom() {
        let msgData = userInfo.data()
        sendMessage(data: msgData, type: 0)
    }
    
    func sendLeaveRoom() {
        let msgData = userInfo.data()
        sendMessage(data: msgData, type: 1)
    }
    
    func sendTextMsg(message: String) {
        let textMsg = TextMessage.Builder()
        textMsg.user = userInfo
        textMsg.text = message
        let textData = (try! textMsg.build()).data()
        sendMessage(data: textData, type: 2)
    }
    
    func sendGiftMsg(giftName: String, giftURL: String, giftCount: Int) {
        let giftMsg = GiftMessage.Builder()
        giftMsg.user = userInfo
        giftMsg.giftname = giftName
        giftMsg.gitUrl = giftURL
        giftMsg.giftCount = String(giftCount)
        let giftData = (try! giftMsg.build()).data()
        sendMessage(data: giftData, type: 3)
    }
    
    func sendHeartBeat() {
        let heartString = "❤️"
        let heartData = heartString.data(using: .utf8)!
        sendMessage(data: heartData, type: 100)
    }
    
    func sendMessage(data: Data, type: Int) {
        var length = data.count
        let headerData = Data(bytes: &length, count: 4)
        var tempType = type
        let typeData = Data(bytes: &tempType, count: 2)
        let totalData = headerData + typeData + data
        tcpClient.send(data: totalData)
    }
    
}
