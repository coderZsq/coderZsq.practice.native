//
//  Controller.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/10.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

class Controller: ViewController {

    fileprivate lazy var viewModel: ViewModel = ViewModel()
    fileprivate lazy var presenter: Presenter = Presenter()
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
        adapterView()
        var url = URL(string: "")
        url?.scheme
    }
}

extension Controller {
    
    fileprivate func setupView() {
        view.addSubview(baseView)
    }
    

    fileprivate func adapterView() {
        presenter.adapter(viewModel: viewModel, view: baseView)
    }
}
