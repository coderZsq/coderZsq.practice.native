//
//  TouchIDViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/12/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TouchID"
    }
    
    @IBAction func touchIDClick(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "localizedReason") { (success, replyError) in
                print(success, replyError ?? "")
            }
        } else {
            print(error ?? "")
        }
    }
}
