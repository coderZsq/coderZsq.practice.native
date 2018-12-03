//
//  vc1InterfaceController.swift
//  WatchOS Extension
//
//  Created by 朱双泉 on 2018/12/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import WatchKit
import Foundation

private var index = 0

class vc1InterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard index == 0 else {
            return;
        }
        WKInterfaceController.reloadRootControllers(withNames: ["vc1", "vc2", "vc3", "vc4"], contexts: nil)
        index += 1
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
