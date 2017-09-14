//
//  Router.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/12.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

class Router {
    static let shareRouter = Router()
    var params: [String : Any]?
    var routers: [String : Any]?
    fileprivate let map = ["J1" : "Controller"]
    
    func guardRouters(finishedCallback : @escaping () -> ()) {
        
        Http.requestData(.get, URLString: "http://localhost:3001/api/J1/getRouters") { (response) in
            guard let result = response as? [String : Any] else { return }
            guard let data:[String : Any] = result["data"] as? [String : Any] else { return }
            guard let routers:[String : Any] = data["routers"] as? [String : Any] else { return }
            self.routers = routers
            finishedCallback()
        }
    }
}

extension Router {
    
    func addParam(key: String, value: Any) {
        params?[key] = value
    }
    
    func clearParams() {
        params?.removeAll()
    }
    
    func push(_ path: String) {
        
        guardRouters {
            guard let state = self.routers?[path] as? String else { return }
            
            if state == "app" {
                guard let nativeController = NSClassFromString("RouterPatterm.\(self.map[path]!)") as? UIViewController.Type else { return }
                currentController?.navigationController?.pushViewController(nativeController.init(), animated: true)
            }
            
            if state == "web" {
                
                let host = "http://localhost:3000/"
                var query = ""
                let ref = "client=app"
                
                guard let params = self.params else { return }
                for (key, value) in params {
                    query += "\(key)=\(value)&"
                }
                
                self.clearParams()
                
                let webViewController = WebViewController("\(host)\(path)?\(query)\(ref)")
                currentController?.navigationController?.pushViewController(webViewController, animated: true)
            }
        }
    }
}
