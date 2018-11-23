//
//  Annotation.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/1.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
