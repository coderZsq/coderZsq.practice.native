//
//  InterfaceController.swift
//  WatchOS Extension
//
//  Created by 朱双泉 on 2018/12/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    override init() {
        super.init()
        print("init")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("awake")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("willActivate")
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("didDeactivate")
    }

    deinit {
        print("deinit")
    }
}
