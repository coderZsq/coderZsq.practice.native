//
//  ServerManager.swift
//  LiveBroadcastServer
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Cocoa

class ServerManager {
    fileprivate lazy var serverSocket = TCPServer(addr: "0.0.0.0", port: 6666)
    fileprivate var isServerRunning = false
    fileprivate lazy var clientManagers = [ClientManager]()
}

extension ServerManager {
    func startRunning() {
        serverSocket.listen()
        isServerRunning = true
        DispatchQueue.global().async {
            while self.isServerRunning {
                if let client = self.serverSocket.accept() {
                    DispatchQueue.global().async {
                        self.handlerClient(client)
                    }
                }
            }
        }
    }
    
    func stopRunning() {
        isServerRunning = false
    }
    
}

extension ServerManager {
    
    fileprivate func handlerClient(_ client: TCPClient) {
        let manager = ClientManager(tcpClient: client)
        clientManagers.append(manager)
        manager.startReadMessage()
    }
    
}
