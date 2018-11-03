//
//  BaiduMapKitTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/2.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class BaiduMapKitTool: NSObject {
    
    typealias POIResultClosure = (_ poiInfos: [BMKPoiInfo]) -> ()

    static let shared = BaiduMapKitTool()
    
    var _mapManager: BMKMapManager?
    
    var poiResultClosure: POIResultClosure?
    
    func authorization() {
        _mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("cb9NG9RoZh3OOUSWGVCDVOKHxDSA8btc", generalDelegate: nil)
        if ret == false {
            NSLog("manager start failed!")
        }
    }
    
    lazy var searcher: BMKPoiSearch = {
        let searcher = BMKPoiSearch()
        searcher.delegate = self
        return searcher
    }()
    
    func POIResult(coordinate: CLLocationCoordinate2D, keyword: String?, resultClosure: @escaping POIResultClosure) {
        poiResultClosure = resultClosure
        let option = BMKNearbySearchOption()
        option.pageIndex = 0
        option.pageCapacity = 20
        option.location = coordinate
        option.keyword = keyword
        let flag = searcher.poiSearchNear(by: option)
        if flag {
            print("检索成功")
        } else {
            print("检索失败")
        }
    }
    
    class func addAnnotation(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, toMapView: BMKMapView) {
        let annoation = BMKPointAnnotation()
        annoation.coordinate = coordinate
        annoation.title = title
        annoation.subtitle = subtitle
        toMapView.addAnnotation(annoation)
    }
}

extension BaiduMapKitTool: BMKPoiSearchDelegate {
    
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        if errorCode == BMK_SEARCH_NO_ERROR {
            guard let poiResultClosure = poiResultClosure, let poiResult = poiResult else {return}
            poiResultClosure(poiResult.poiInfoList as! [BMKPoiInfo])
        } else {
            print(errorCode.rawValue)
        }
    }
}
