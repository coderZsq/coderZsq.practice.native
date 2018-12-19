//
//  RxTableViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import RxSwift

class RxTableViewController: UITableViewController {

    fileprivate lazy var bag = DisposeBag()
    fileprivate var rxModels: [RxModel]?
    let RxVM = RxViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        RxVM.rxObserable.asObservable().bind(to: tableView.rx.items(cellIdentifier: "rx", cellType: UITableViewCell.self)) { row, rxmodel, cell in
            cell.textLabel?.text = rxmodel.name
            cell.detailTextLabel?.text = rxmodel.download
            cell.imageView?.setImage(rxmodel.icon, nil)
        }.disposed(by: bag)
        
        tableView.rx.itemDeselected.subscribe(onNext: { (indexPath) in
            print(indexPath)
        }).disposed(by: bag)
        
        tableView.rx.modelSelected(RxModel.self).subscribe(onNext: { (rxmodel) in
            print(rxmodel.name)
        }).disposed(by: bag)
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { (timer) in
            let model = RxModel(dict: ["name" : "Castiel", "icon" : "", "download" : "6666"])
            self.RxVM.rxObserable.value = [model]
            timer.invalidate()
        }
    }
    
}
