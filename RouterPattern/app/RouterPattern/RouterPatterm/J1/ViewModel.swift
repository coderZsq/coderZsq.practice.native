//
//  ViewModel.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

class ViewModel: ViewModelInterface {
    lazy var models: [ModelInterface] = [ModelInterface]()
}

extension ViewModel {
    
    func dynamicBinding(finishedCallback : @escaping () -> ()) {
        
        Http.requestData(.get, URLString: "http://localhost:3001/api/J1/getJ1List") { (response) in
            guard let result = response as? [String : Any] else { return }
            guard let data:[String : Any] = result["data"] as? [String : Any] else { return }
            guard let models:[[String : Any]] = data["models"] as? [[String : Any]] else { return }
            
            self.models.removeAll()
            for dict in models {
                self.models.append(Model(dict: dict))
            }
            
            finishedCallback()
        }
    }
}
