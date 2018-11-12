//
//  ShowMessageTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

class ShowMessageTool {
    
    class func showMessage(_ message: String) {
        let vc = UIApplication.shared.keyWindow?.rootViewController
        let alert = UIAlertController(title: "Tips", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .default, handler: { (action) in
            vc?.dismiss(animated: true, completion: nil)
        })
        alert.addAction(action)
        vc?.present(alert, animated: true, completion: nil)
    }
}
