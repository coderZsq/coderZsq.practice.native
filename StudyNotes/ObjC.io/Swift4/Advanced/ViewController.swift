//
//  ViewController.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/1.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        BuiltInCollectionType.run()
        CollectionTypeProtocol.run()
        OptionalValue.run()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserDetailSegue",
            let userDetailVC = segue.destination
            as? ViewController
        {
            userDetailVC.title = "Hello"
        }
    }
}

