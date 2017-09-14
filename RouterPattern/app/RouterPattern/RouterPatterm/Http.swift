//
//  Http.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/10.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import Alamofire

enum MethodType {
    case get
    case post
}

class Http {
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            finishedCallback(result)
        }
    }
}
