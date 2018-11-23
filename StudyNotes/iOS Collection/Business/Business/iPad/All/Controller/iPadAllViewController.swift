//
//  iPadAllViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class iPadAllViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = ["item0", "item1", "item2", "item3"]
        let segment = UISegmentedControl(items: items)
        segment.tintColor = .darkGray
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segment.setTitleTextAttributes(attributes, for: .selected)
        segment.selectedSegmentIndex = 0
        navigationItem.titleView = segment
    }
    
}
