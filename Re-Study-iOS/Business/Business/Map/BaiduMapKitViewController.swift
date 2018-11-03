//
//  BaiduMapKitViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/2.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class BaiduMapKitViewController: UIViewController {
    
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
        BaiduMapKitTool.shared.POIResult(coordinate: coordinate, keyword: "小吃") { (poiInfos) in
            for poiInfo in poiInfos {
                print(poiInfo.name)
                BaiduMapKitTool.addAnnotation(coordinate: poiInfo.pt, title: poiInfo.city, subtitle: poiInfo.address, toMapView: mapView)
            }
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
