//
//  ViewController.swift
//  CocoaTouch
//
//  Created by 朱双泉 on 2018/4/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nib_button: Button!
    
    override func loadView() {
        super.loadView();
        
        let uibutton = UIButton()
        uibutton.layer.borderWidth = 1
        uibutton.layer.borderColor = UIColor.black.cgColor
        
        uibutton.frame = CGRect(x: 0, y: 50, width: 44, height: 44)
        uibutton.setTitle("github.com/coderZsq", for: .normal)
        uibutton.setTitleColor(.red, for: .normal)
//        uibutton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        uibutton.setImage(UIImage(named: "avatar"), for: .normal)
//        uibutton.setBackgroundImage(UIImage(named: "avatar"), for: .normal)
//        uibutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        view.addSubview(uibutton)
        uibutton.sizeToFit()
        
        let button = Button()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor

        button.frame = CGRect(x: 0, y: 300, width: 44, height: 40)
        button.setTitle("github.com/coderZsq")
        button.setTitleColor(.red)
//        button.setTitleEdgeInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        button.setImage(UIImage(named: "avatar") ?? UIImage())
//        button.setBackgroundImage(UIImage(named: "avatar") ?? UIImage())
//        button.setImageEdgeInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        view.addSubview(button)
        button.sizeToFit()
        
        nib_button.layer.borderWidth = 1
        nib_button.layer.borderColor = UIColor.black.cgColor
        
        nib_button.setTitle("github.com/coderZsq")
        nib_button.setTitleColor(.red)
//        nib_button.setTitleEdgeInsets(.zero)
        nib_button.setImage(UIImage(named: "avatar") ?? UIImage())
//        nib_button.setBackgroundImage(UIImage(named: "avatar") ?? UIImage())
        nib_button.setImageEdgeInsets(.zero)

    }
}

