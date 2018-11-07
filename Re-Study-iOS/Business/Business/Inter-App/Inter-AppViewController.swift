//
//  Inter-AppViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class Inter_AppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let url = URL(string: "tel://10086") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
