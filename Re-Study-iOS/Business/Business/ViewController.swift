//
//  ViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/10/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifer = "reuseIdentifer"

class ViewController: UITableViewController {

    lazy var dataSource: [[String : Any]] = {
        let dataSource = [["classes" : [LocationViewController.self,
                                        MapViewController.self,
                                        IAPViewController.self,
                                        ADViewController.self,
                                        NotificationViewController.self,
                                        SensorViewController.self,
                                        DynamicViewController.self],
                          "titleheader" : "practical-tech",
                          "titlefooter" : "Some example of practical-tech learning."]]
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
    }
}

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let classes = self.dataSource[section]["classes"] as? [AnyClass] else {return 0}
        return classes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        cell.imageView?.image = UIImage(named: "Mark")
        if let classes = self.dataSource[indexPath.section]["classes"] as? [AnyClass] {
            cell.textLabel?.text = NSStringFromClass(classes[indexPath.row]).components(separatedBy: ".").last
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let classes = self.dataSource[indexPath.section]["classes"] as? [AnyClass] else {return}
        guard let name = NSStringFromClass(classes[indexPath.row]).components(separatedBy: ".").last else {return}
        guard let viewController = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {return}
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.dataSource[section]["titleheader"] as? String
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.dataSource[section]["titlefooter"] as? String
    }
}

