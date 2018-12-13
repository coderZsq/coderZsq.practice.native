//
//  ServerManager.swift
//  LiveBroadcastServer
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Cocoa

class ServerManager: NSObject {
    fileprivate lazy var serverSocket : TCPServer = TCPServer(addr: "0.0.0.0", port: 6666)
    
    fileprivate var isServerRunning = false
}

extension ServerManager {
    func startRunning() {
        // 1.开启监听
        serverSocket.listen()
        isServerRunning = true
        
        // 2.开始接受客户端
        DispatchQueue.global().async {
            while self.isServerRunning {
                if let client = self.serverSocket.accept() {
                    DispatchQueue.global().async {
                        print("接收到一个客户端的链接")
                    }
                }
            }
        }
    }
    
    func stopRunning() {
        isServerRunning = false
    }
    
}
