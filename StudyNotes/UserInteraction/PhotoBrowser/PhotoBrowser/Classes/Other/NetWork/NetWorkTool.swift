//
//  NetWorkTool.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AFNetworking

enum RequestType {
    case get
    case post
}

class NetWorkTool: NSObject {
    
    static func request(type: RequestType, url: String, parameters: [String : Any], result: @escaping (Any?, Error?)->()) {
        let manager = AFHTTPSessionManager()
        let success = { (task: URLSessionDataTask, responseObject: Any?) in
            result(responseObject, nil)
        }
        let failure = { (task: URLSessionDataTask?, error: Error) in
            result(nil, error)
        }
        if type == .get {
            manager.get(url, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            manager.post(url, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
