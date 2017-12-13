//
//  Presenter.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

protocol ModelInterface {
    var text : String {get set}
    var detailText : String {get set}
    var imageUrl : String {get set}
}

protocol ViewInterface:class {
    var viewModel: ViewModelInterface? {get set}
    var operation: ViewOperation? {get set}
}

protocol ViewModelInterface:class {
    var models: [ModelInterface] {get set}
    func dynamicBinding(finishedCallback : @escaping () -> ())
}

class Presenter {
    weak var view: ViewInterface?
    weak var viewModel: ViewModelInterface?
}

extension Presenter {
    
    func adapter<VM: ViewModelInterface,V: ViewInterface>(viewModel: VM,  view: V) {
        
        self.view = view;
        self.viewModel = viewModel
        
        func dynamicBinding() {
            self.viewModel?.dynamicBinding { [weak self] in
                self?.view?.viewModel = viewModel
                self?.view?.operation = self
            }
        }; dynamicBinding()
    }
}


extension Presenter: ViewOperation {
    
    func pushTo() {
        Router.shareRouter.params = [
            "text" : "app端 传入数据",
            "code" : 1001
        ]
        Router.shareRouter.push("J1")
    }
}
