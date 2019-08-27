//
//  HomeViewController.swift
//  29-项目实战
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
}
