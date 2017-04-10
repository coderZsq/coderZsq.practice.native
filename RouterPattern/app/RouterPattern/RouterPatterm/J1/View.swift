//
//  View.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/10.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

class View: UIView {
    
    var models: [Model]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate lazy var tableView: UITableView = { [weak self] in
        var tableView = UITableView(frame: self!.bounds, style: .plain)
        tableView.dataSource = self
        return tableView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension View: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "identifier"
        let model: Model? = models?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: identifier)
        cell.textLabel?.text = model?.text
        cell.detailTextLabel?.text = model?.detailText
        return cell
    }
}
