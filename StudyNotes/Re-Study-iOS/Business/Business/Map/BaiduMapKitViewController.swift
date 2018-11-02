//
//  BaiduMapKitViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/2.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class BaiduMapKitViewController: UIViewController {

    lazy var searcher: BMKPoiSearch = {
        let searcher = BMKPoiSearch()
        searcher.delegate = self
        return searcher
    }()
    
    @IBOutlet weak var mapView: BMKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "BaiduMapKit"
        mapView.delegate = self
    }
}

extension BaiduMapKitViewController: BMKMapViewDelegate {
    
    func mapview(_ mapView: BMKMapView!, onLongClick coordinate: CLLocationCoordinate2D) {
        let span = BMKCoordinateSpan(latitudeDelta: 0.017012344791176304, longitudeDelta: 0.019744755109314838)
        let region = BMKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let option = BMKNearbySearchOption()
        option.pageIndex = 0
        option.pageCapacity = 20
        option.location = coordinate
        option.keyword = "小吃"
        let flag = searcher.poiSearchNear(by: option)
        if flag {
            print("检索成功")
        } else {
            print("检索失败")
        }
    }
    
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        print(mapView.region.span)
    }
    
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        if let annotation = view.annotation as? BMKPointAnnotation, let title = annotation.title {
            print("点击了\(title)")
        }
    }
}

extension BaiduMapKitViewController: BMKPoiSearchDelegate {
    
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPoiResult!, errorCode: BMKSearchErrorCode) {
        if errorCode == BMK_SEARCH_NO_ERROR {
            for poiInfo in poiResult.poiInfoList {
                if let poiInfo = poiInfo as? BMKPoiInfo {
                    print(poiInfo.name)
                    let annoation = BMKPointAnnotation()
                    annoation.coordinate = poiInfo.pt
                    annoation.title = poiInfo.name
                    annoation.subtitle = poiInfo.address
                    mapView.addAnnotation(annoation)
                }
            }
        } else {
            print(errorCode.rawValue)
        }
    }
}
