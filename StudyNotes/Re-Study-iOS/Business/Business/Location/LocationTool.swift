//
//  LocationTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/10/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import CoreLocation

class LocationTool: NSObject {

    typealias ResultClosure = (_ location: CLLocation?, _ errorMessage: String?) -> ()

    static let shared = LocationTool()
    
    var resultClosure: ResultClosure?
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        if #available(iOS 8.0, *), let infoDic = Bundle.main.infoDictionary {
            if infoDic["NSLocationAlwaysUsageDescription"] != nil {
                locationManager.requestAlwaysAuthorization()
            } else if infoDic["NSLocationWhenInUseUsageDescription"] != nil {
                locationManager.requestWhenInUseAuthorization()
                if #available(iOS 9.0, *), let backModes = infoDic["UIBackgroundModes"] as? String, backModes.contains("location") {
                    locationManager.allowsBackgroundLocationUpdates = true
                }
            } else {
                print("温馨提示: 如果想要在iOS8.0以后, 获取用户位置, 需要在info.plist文件当中配置NSLocationWhenInUseUsageDescription或者NSLocationAlwaysUsageDescription")
            }
        }
        return locationManager
    }()
    
    func getCurrentLocation(result: @escaping ResultClosure) -> ()  {
        resultClosure = result
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            if let resultClosure = resultClosure{
                resultClosure(nil, "当前并不能获取到位置信息")
            }
        }
    }
}

extension LocationTool: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        if let resultClosure = resultClosure {
            resultClosure(location, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let resultClosure = resultClosure {
            resultClosure(nil, "当前定位失败")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("用户没有决定")
        case .restricted:
            print("受限制")
        case .denied:
            if CLLocationManager.locationServicesEnabled() {
                print("真正的被拒绝")
                if #available(iOS 10.0, *), let url = URL(string: UIApplication.openSettingsURLString /*prefs:root=LOCATION_SERVICES*/), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, completionHandler: nil)
                }
            } else {
                print("请打开定位服务")
            }
        case .authorizedAlways:
            print("前后台定位授权")
        case .authorizedWhenInUse:
            print("前台定位授权")
        }
    }
}
