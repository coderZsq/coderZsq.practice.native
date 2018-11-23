//
//  iPadMoodViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class iPadMoodViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "mood"
        view.backgroundColor = UIColor(red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0, alpha: 1)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(leftBarButtonItemClick(sender:)))
    }
    
    @objc
    func leftBarButtonItemClick(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
