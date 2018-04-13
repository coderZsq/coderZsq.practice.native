//
//  ViewController.swift
//  CocoaTouch
//
//  Created by 朱双泉 on 2018/4/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView();
        let button = Button()
        button.setTitle("title")
        button.setTitleColor(.red)
        button.setTitleEdgeInsets(UIEdgeInsets())
        button.setImage(UIImage());
        button.setBackgroundImage(UIImage())
        button.setImageEdgeInsets(UIEdgeInsets())
        view.addSubview(button)
    }
}

