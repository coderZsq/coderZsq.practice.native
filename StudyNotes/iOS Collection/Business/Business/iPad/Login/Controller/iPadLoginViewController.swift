//
//  iPadLoginViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class iPadLoginViewController: UIViewController {
    
    @IBOutlet weak var animatedView: UIStackView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberPasswordSwitch: UISwitch!
    @IBOutlet weak var autoLoginSwitch: UISwitch!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBAction func loginButtonClick(_ sender: UIButton?) {
        view.isUserInteractionEnabled = false
        indicator.startAnimating()
        if let account = accountTextField.text, let password = passwordTextField.text {
            LoginTool.login(account: account, password: password) { (isSuccess) in
                if isSuccess {
                    print("成功")
                    if let vc = UIStoryboard(name: "iPadHomeViewController", bundle: nil).instantiateInitialViewController() {
                        self.present(vc, animated: false, completion: nil)
                    }
                } else {
                    print("失败")
                    ShowMessageTool.showMessage("Account or Password is Wrong")
                    let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
                    animation.values = [-20, 0, 20, 0]
                    animation.repeatCount = 3
                    animation.duration = 0.1
                    self.animatedView.layer.add(animation, forKey: "error")
                }
                self.view.isUserInteractionEnabled = true
                self.indicator.stopAnimating()
            }
        }
    }
    
    @IBAction func rememberPasswordValueChanged(_ sender: UISwitch) {
        sender.isOn = !sender.isOn
        if !sender.isSelected {
            autoLoginSwitch.isOn = false
        }
    }
    
    @IBAction func autoLoginValueChanged(_ sender: UISwitch) {
        sender.isOn = !sender.isOn
        if sender.isSelected {
            rememberPasswordSwitch.isOn = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iPad"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
}

extension iPadLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accountTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            print("登录操作")
            loginButtonClick(nil)
        }
        return true
    }
}

