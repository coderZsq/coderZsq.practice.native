//
//  BaiduMapKitTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/2.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class BaiduMapKitTool: NSObject {

    static let shared = BaiduMapKitTool()
    
    var _mapManager: BMKMapManager?
    
    @discardableResult
    func mapAuthorization() -> BaiduMapKitTool {
        _mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("cb9NG9RoZh3OOUSWGVCDVOKHxDSA8btc", generalDelegate: nil)
        if ret == false {
            NSLog("manager start failed!")
        }
        return self
    }
    
    @discardableResult
    func navigationAuthorization() -> BaiduMapKitTool {
        return self
    }
}
