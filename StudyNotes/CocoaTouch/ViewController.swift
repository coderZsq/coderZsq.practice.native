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
        
        let uibutton = UIButton()
        uibutton.layer.borderWidth = 1
        uibutton.layer.borderColor = UIColor.black.cgColor
        
        uibutton.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: 40)
        uibutton.setTitle("github.com/coderZsq", for: .normal)
        uibutton.setTitleColor(.red, for: .normal)
//        uibutton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
//        uibutton.setImage(UIImage(named: "avatar"), for: .normal)
        uibutton.setBackgroundImage(UIImage(named: "avatar"), for: .normal)
//        uibutton.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10)
        view.addSubview(uibutton)
        uibutton.sizeToFit()
        
        let button = Button()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        
        button.frame = CGRect(x: 0, y: 350, width: view.bounds.width, height: 40)
        button.setTitle("github.com/coderZsq")
        button.setTitleColor(.red)
//        button.setTitleEdgeInsets(UIEdgeInsetsMake(0, 0, 0, 0))
//        button.setImage(UIImage(named: "avatar") ?? UIImage());
        button.setBackgroundImage(UIImage(named: "avatar") ?? UIImage())
//        button.setImageEdgeInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        view.addSubview(button)
        button.sizeToFit()
    }
}

