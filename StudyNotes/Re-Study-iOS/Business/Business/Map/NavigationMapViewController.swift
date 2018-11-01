//
//  NavigationMapViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/1.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MapKit

class NavigationMapViewController: UIViewController {

    lazy var geoCoder = CLGeocoder()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NavigationMap"
        let circle = MKCircle(center: mapView.centerCoordinate, radius: 100000)
        mapView.addOverlay(circle)
        geoCoder.geocodeAddressString("Shanghai") { [weak self] (placemarks, error)  in
            let shanghai = placemarks?.first
            self?.geoCoder.geocodeAddressString("Beijing", completionHandler: { (placemarks, error) in
                let beijing = placemarks?.first
                //                self?.beginNavigation(start: shanghai, end: beijing)
                self?.getRouteMessage(start: shanghai, end: beijing)
            })
        }
    }
    
    func getRouteMessage(start: CLPlacemark?, end: CLPlacemark?) {
        guard let start = start, let end = end else {
            return
        }
        let request = MKDirections.Request()
        let startPlacemark = MKPlacemark(placemark: start)
        let startItem = MKMapItem(placemark: startPlacemark)
        request.source = startItem
        let endPlacemark = MKPlacemark(placemark: end)
        let endItem = MKMapItem(placemark: endPlacemark)
        request.destination = endItem
        let directions = MKDirections(request: request)
        directions.calculate { (response, error) in
            guard error == nil, let response = response else {return}
            for route in response.routes {
                print(route.name, route.distance)
                self.mapView.addOverlay(route.polyline)
                for step in route.steps {
                    print(step.instructions)
                }
            }
        }
    }
    
    func beginNavigation(start: CLPlacemark?, end: CLPlacemark?) {
        guard let start = start, let end = end else {
            return
        }
        let startPlacemark = MKPlacemark(placemark: start)
        let startItem = MKMapItem(placemark: startPlacemark)
        let endPlacemark = MKPlacemark(placemark: end)
        let endItem = MKMapItem(placemark: endPlacemark)
        let items = [startItem, endItem]
        let launchOptions: [String : Any] =
            [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
             MKLaunchOptionsMapTypeKey : MKMapType.standard.rawValue,
             MKLaunchOptionsShowsTrafficKey : true]
        MKMapItem.openMaps(with: items, launchOptions: launchOptions)
    }
}

extension NavigationMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            let render = MKCircleRenderer(overlay: overlay)
            render.fillColor = .darkGray
            render.alpha = 0.5
            return render
        }
        if overlay is MKPolyline {
            let render = MKPolylineRenderer(overlay: overlay)
            render.lineWidth = 2
            render.strokeColor = .darkGray
            return render
        }
        return MKOverlayRenderer()
    }
}
