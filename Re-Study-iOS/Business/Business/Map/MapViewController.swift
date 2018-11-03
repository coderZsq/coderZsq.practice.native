//
//  MapViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/1.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MapKit

fileprivate var reuseIdentifer = "identifer"

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    lazy var geoCoder = CLGeocoder()
    
    lazy var locationManager = LocationTool.shared.locationManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Navigation", style: .plain, target: self, action: #selector(navigationBarButtonClick))
        
        mapView.mapType = .standard
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        mapView.isZoomEnabled = true
        mapView.showsBuildings = true
        mapView.showsPointsOfInterest = true
        if #available(iOS 9.0, *) {
            mapView.showsCompass = true
            mapView.showsScale = true
            mapView.showsTraffic = true
        }
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        mapView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        mapView.removeAnnotations(mapView.annotations)
        if let point = touches.first?.location(in: mapView) {
            let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
            let annotation = addAnnotation(coordinate: coordinate, title: "Castiel", subtitle: "666")
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if error == nil {
                    let placemark = placemarks?.first
                    annotation.title = placemark?.locality
                    annotation.subtitle = placemark?.name
                }
            }
        }
    }
}

extension MapViewController {
    
    @objc func navigationBarButtonClick() {
        guard let viewController = UIStoryboard(name: "NavigationMapViewController", bundle: nil).instantiateInitialViewController() else {
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func addAnnotation(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) -> Annotation {
        let annotation = Annotation(coordinate: coordinate, title: title, subtitle: subtitle)
        mapView.addAnnotation(annotation)
        return annotation
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        userLocation.title = "Castie!"
        userLocation.subtitle = "CoderZsq"
//        print(userLocation.location?.coordinate)
        if let coordinate = userLocation.location?.coordinate {
//            mapView.setCenter(coordinate, animated: true)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(mapView.region.span)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        print("选中大头针视图---", annotation)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        print("取消选中大头针视图---", annotation)
    }
    
    private func mapView1(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("获取大头针视图")
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifer) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifer)
        }
        annotationView?.annotation = annotation
        if #available(iOS 9.0, *) {
            annotationView?.pinTintColor = .darkGray
        }
        annotationView?.canShowCallout = true
        return annotationView
    }
    
    private func mapView2(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifer)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifer)
        }
        annotationView?.annotation = annotation
        annotationView?.image = UIImage(named: "Pin")
        annotationView?.canShowCallout = true
        annotationView?.centerOffset = CGPoint(x: 10, y: 10)
        annotationView?.calloutOffset = CGPoint(x: -10, y: -10)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.image = UIImage(named: "Mark")
        annotationView?.leftCalloutAccessoryView = imageView
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView2.image = UIImage(named: "Mark")
        annotationView?.rightCalloutAccessoryView = imageView2
        if #available(iOS 9.0, *) {
            annotationView?.detailCalloutAccessoryView = UISwitch()
        }
        return annotationView
    }
}
