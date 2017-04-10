//
//  Controller.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/10.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

class Controller: UIViewController {

    fileprivate lazy var models: [Model] = [Model]()
    fileprivate lazy var baseView: View = { [weak self] in
        return View(frame: self!.view.bounds)
    }()
    
    override func loadView() {
        super.loadView()
        title = "J1"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        requestData()
    }
}

extension Controller {
    
    fileprivate func setupView() {
        view.addSubview(baseView)
    }
    
    fileprivate func requestData() {
        Http.requestData(.get, URLString: "http://localhost:3001/api/J1/getJ1List") { (response) in
            guard let result = response as? [String : Any] else { return }
            guard let data:[String : Any] = result["data"] as? [String : Any] else { return }
            guard let models:[[String : Any]] = data["models"] as? [[String : Any]] else { return }
            
            self.models.removeAll()
            for dict in models {
                self.models.append(Model(dict: dict))
            }
            self.adapterView()
        }
    }
    
    fileprivate func adapterView() {
        baseView.models = models
    }
}
