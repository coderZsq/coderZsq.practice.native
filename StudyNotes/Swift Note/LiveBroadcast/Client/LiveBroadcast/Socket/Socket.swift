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
    
}
