//
//  IAPViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import StoreKit

fileprivate var reuseIdentifer = "identifier";

class IAPViewController: UITableViewController {

    var products: [SKProduct]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "IAP"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        IAPTool.requiredProducts { (productIdentifiers) in
            IAPTool.shared.requestAvaliableProducts(productIdentifiers: productIdentifiers, result: { (products) in
                self.products = products
            })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        IAPTool.shared.restore()
    }
}

extension IAPViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let products = products else {
            return 0
        }
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        if let products = products {
            let product = products[indexPath.row]
            cell.textLabel?.text = product.localizedTitle
            cell.detailTextLabel?.text = product.localizedDescription + "\(product.price)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let products = products  {
            IAPTool.shared.purchase(product: products[indexPath.row]) { (state) in
                print(state.rawValue)
            }
        }
    }
}
