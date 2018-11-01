//
//  MapViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/1.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    lazy var geoCoder = CLGeocoder()
    
    lazy var locationManager = LocationTool.shared.locationManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"
        
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
}
