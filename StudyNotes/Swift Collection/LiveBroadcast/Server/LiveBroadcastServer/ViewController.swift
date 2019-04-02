//
//  ViewController.swift
//  LiveBroadcastServer
//
//  Created by 朱双泉 on 2018/12/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var hintLabel: NSTextField!
    fileprivate lazy var serverMgr : ServerManager = ServerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startServer(_ sender: NSButton) {
        serverMgr.startRunning()
        hintLabel.stringValue = "服务器已经开启ing"
    }
    
    @IBAction func stopServer(_ sender: NSButton) {
        serverMgr.stopRunning()
        hintLabel.stringValue = "服务器未开启"
    }
}

