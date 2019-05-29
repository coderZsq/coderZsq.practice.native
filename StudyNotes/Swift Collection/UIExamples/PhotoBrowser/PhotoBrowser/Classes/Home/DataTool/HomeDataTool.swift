//
//  HomeDataTool.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class HomeDataTool: NSObject {
    
    static func requestHomeDataList(page: Int = 1, request: @escaping ([ProductModel]) -> ()) {
        let parameters = [
            "opt_type" : 1,
            "size" : 50,
            "offset" : (page - 1) * 20
        ]
        NetWorkTool.request(type: .get, url: kRequestURL, parameters: parameters) { (response, error) in
            if let response = response {
                var models = [ProductModel]()
                if let resultObject = response as? [String : Any] {
                    if let dicArray = resultObject["goods_list"] as? [[String : Any]] {
                        for dic in dicArray {
                            let model = ProductModel(dic: dic)
                            models.append(model)
                        }
                    }
                }
                request(models)
            } else {
                print(error ?? "")
                var models = [ProductModel]()
                for _ in 0...20 {
                    let model = ProductModel()
                    model.hd_thumb_url = "https://avatars2.githubusercontent.com/u/19483268?s=400&u=97869a443baab2820618a8a575cee677b80849c7&v=4"
                    model.thumb_url = "https://avatars2.githubusercontent.com/u/19483268?s=400&u=97869a443baab2820618a8a575cee677b80849c7&v=4"
                    models.append(model)
                }
                request(models)
            }
        }
    }
}
