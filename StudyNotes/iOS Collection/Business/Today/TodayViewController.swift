//
//  TodayViewController.swift
//  Today
//
//  Created by 朱双泉 on 2018/12/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBAction func buttonClick(_ sender: UIButton) {
        let url = URL(string: "business://extension")!
        extensionContext?.open(url, completionHandler: { (result) in
            if result == true {
                print("open success")
            }
        })
    }
    
    deinit {
        print(#function, #line)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let d = UserDefaults(suiteName: "group.castiel")
        d?.set("today", forKey: "key")
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
