//
//  LrcViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class LrcViewController: UITableViewController {

    var lrcModels = [LrcModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var scrollRow: Int = -1 {
        didSet {
            if scrollRow == oldValue {return}
            let indexPath = IndexPath(row: scrollRow, section: 0)
            if let rows = tableView.indexPathsForVisibleRows {
                tableView.reloadRows(at: rows, with: .fade)
                tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
            }
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            let indexPath = IndexPath(row: scrollRow, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as? LrcCell
            cell?.lrcLabel.progress = progress
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "LrcCell", bundle: nil), forCellReuseIdentifier: "reuseIdentifier")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: tableView.height * 0.5, left: 0, bottom: tableView.height * 0.5, right: 0)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lrcModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! LrcCell
        cell.backgroundColor = .clear
        if scrollRow == indexPath.row {
            cell.lrcLabel.progress = progress
        } else {
            cell.lrcLabel.progress = 0
        }
        cell.lrcLabel.textAlignment = .center
        cell.lrcLabel.textColor = .white
        cell.lrcLabel.text = lrcModels[indexPath.row].lrcContent
        return cell
    }
}
