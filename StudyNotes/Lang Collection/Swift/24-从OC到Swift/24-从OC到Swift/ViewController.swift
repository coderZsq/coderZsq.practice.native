//
//  ViewController.swift
//  24-从OC到Swift
//
//  Created by 朱双泉 on 2019/8/19.
//  Copyright © 2019 Castie!. All rights reserved.
//

import UIKit

enum R {
    enum string: String {
        case add = "添加"
    }
    enum image: String {
        case logo
    }
    enum segue: String {
        case login_main
    }
}

extension UIImage {
    convenience init?(_ name: R.image) {
        self.init(named: name.rawValue)
    }
}

extension UIViewController {
    func performSegue(withIdentifier identifier: R.segue, sender: Any?) {
        performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
}

extension UIButton {
    func setTitle(_ title: R.string, for state: UIControl.State) {
        setTitle(title.rawValue, for: state)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - 资源名管理

        do {
            let img = UIImage(named: "logo")
            let btn = UIButton(type: .custom)
            btn.setTitle("添加", for: .normal)
            performSegue(withIdentifier: "login_main", sender: self)
        }
        
        do {
            let img = UIImage(R.image.logo)
            let btn = UIButton(type: .custom)
            btn.setTitle(R.string.add, for: .normal)
            performSegue(withIdentifier: R.segue.login_main, sender: self)
        }
        
        // MARK: - 资源名管理的其他思路
        
        do {
            let img = UIImage(named: "logo")
            let font = UIFont(name: "Arial", size: 14)
        }
        
        do {
            enum R {
                enum image {
                    static var logo = UIImage(named: "logo")
                }
                enum font {
                    static func arial(_ size: CGFloat) -> UIFont? {
                        UIFont(name: "Arial", size: size)
                    }
                }
            }
            let img = R.image.logo
            let font = R.font.arial(14)
        }
    }
}
