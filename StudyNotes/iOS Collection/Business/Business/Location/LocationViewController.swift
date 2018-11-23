//
//  LocationViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/10/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import CoreLocation
import INTULocationManager

class LocationViewController: UIViewController {
    
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    var lastLocation: CLLocation?
    @IBOutlet weak var compassImageView: UIImageView!
    @IBOutlet weak var noticeLabel: UILabel!
    
    lazy var geoCoder: CLGeocoder = CLGeocoder()
    
    @IBAction func geoCodingButtonClick(_ sender: UIButton) {
        guard let addressStr = addressTextView.text else {return}
        geoCoder.geocodeAddressString(addressStr) { (placemarks, error) in
            if error == nil {
                print("地理编码成功")
                if let placemarks = placemarks, placemarks.count > 0, let placemark = placemarks.first, let location = placemark.location {
//                    print(placemark.locality)
                    self.addressTextView.text = placemark.name
                    self.latitudeTextField.text = String(describing: location.coordinate.latitude)
                    self.longitudeTextField.text = String(describing: location.coordinate.longitude)
                }
            } else {
                print("地理编码失败")
            }
        }
    }
    
    @IBAction func reverseGeoCodingButtonClick(_ sender: UIButton) {
        guard let latitudeText = latitudeTextField.text else {return}
        guard let longitudeText = longitudeTextField.text else {return}
        let latitude = CLLocationDegrees(latitudeText) ?? 0
        let longitude = CLLocationDegrees(longitudeText) ?? 0
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
            if error == nil {
                print("逆地理编码成功")
            } else {
                print("逆地理编码失败")
            }
        }
    }
    
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        if #available(iOS 8.0, *) {
            if #available(iOS 9.0, *) {
                locationManager.allowsBackgroundLocationUpdates = true
            }
            //            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.distanceFilter = 0.1
        /*
         public let kCLLocationAccuracyBestForNavigation: CLLocationAccuracy
         public let kCLLocationAccuracyBest: CLLocationAccuracy
         public let kCLLocationAccuracyNearestTenMeters: CLLocationAccuracy
         public let kCLLocationAccuracyHundredMeters: CLLocationAccuracy
         public let kCLLocationAccuracyKilometer: CLLocationAccuracy
         public let kCLLocationAccuracyThreeKilometers: CLLocationAccuracy
         */
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Location"
        if CLLocationManager.headingAvailable() {
            locationManager.startUpdatingHeading()
        } else {
            print("你的设备当前不支持获取设备航向")
        }
        startUpdatingLocation()
        startMonitoring()
        latitudeTextField.becomeFirstResponder()
    }
}

extension LocationViewController {
    
    func getCurrentLocation() {
        LocationTool.shared.getCurrentLocation { (location, errorMessage) in
            if errorMessage == nil {
                
            }
        }
    }
    
    func thirdParty() {
        let locationManager_ = INTULocationManager.sharedInstance()
        let requestID = locationManager_.requestLocation(withDesiredAccuracy: .city, timeout: 10.0, delayUntilAuthorized: true) { (location, accuracy, status) in
            if status == .success {
                print("定位成功\(String(describing: location))")
            } else {
                print("定位失败")
            }
        }
        locationManager_.forceCompleteLocationRequest(requestID)
        locationManager_.cancelLocationRequest(requestID)
        
        let locationManager2_ = INTULocationManager.sharedInstance()
        locationManager2_.subscribeToLocationUpdates(withDesiredAccuracy: .block) { (location, accuracy, status) in
            if status == .success {
                print("定位成功\(String(describing: location))")
            } else {
                print("定位失败")
            }
        }
    }
}

extension LocationViewController {
    
    func startMonitoring() {
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let latitude: CLLocationDegrees = CLLocationDegrees(latitudeTextField.text!) ?? 0
            let longitude: CLLocationDegrees = CLLocationDegrees(longitudeTextField.text!) ?? 0
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            var radius = 1000.0
            if radius > locationManager.maximumRegionMonitoringDistance {
                radius = locationManager.maximumRegionMonitoringDistance
            }
            let region: CLCircularRegion = CLCircularRegion(center: center, radius: radius, identifier: "Shanghai")
            locationManager.startMonitoring(for: region)
            locationManager.requestState(for: region)
        }
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
        
        let latitude: CLLocationDegrees = CLLocationDegrees(latitudeTextField.text!) ?? 0
        let longitude: CLLocationDegrees = CLLocationDegrees(longitudeTextField.text!) ?? 0
        let loc1 = CLLocation(latitude: latitude, longitude: longitude)
        
        let latitude2: CLLocationDegrees = 121.49491
        let longitude2: CLLocationDegrees = 31.24169
        let loc2 = CLLocation(latitude: latitude2, longitude: longitude2)
        
        let distance = loc1.distance(from: loc2)
        print(distance)
    }
}

extension LocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        noticeLabel.text = "Enter Region---" + region.identifier
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        noticeLabel.text = "Leave Region---" + region.identifier
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if state == .inside {
            noticeLabel.text = "Enter Region---" + region.identifier
        } else if state == .outside {
            noticeLabel.text = "Leave Region---" + region.identifier
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        if newHeading.headingAccuracy < 0 {
            return
        }
        let angle = newHeading.magneticHeading
        let radian = angle / 180.0 * Double.pi
        UIView.animate(withDuration: 0.5) {
            self.compassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-radian))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitudeTextField.text = String(location.coordinate.latitude)
            longitudeTextField.text = String(location.coordinate.longitude)
            if location.horizontalAccuracy < 0 {
                print("数据无效")
                return
            }
            let courseStrArr = ["北偏东", "东偏南", "南偏西", "西偏北"]
            let index = Int(location.course) / 90
            var courseStr = courseStrArr[index]
            let angle = location.course.truncatingRemainder(dividingBy: 90)
            if angle == 0.0 {
                let tempStr = courseStr as NSString
                courseStr = tempStr.substring(to: 1)
            }
            var distance = 0
            if let lastLocation = lastLocation {
                distance = Int(location.distance(from: lastLocation))
            }
            lastLocation = location
            print(courseStr, angle, "方向, 移动了", distance, "米")
            print("已经获取到位置信息: \(location)")
        }
        manager.stopUpdatingLocation()
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
