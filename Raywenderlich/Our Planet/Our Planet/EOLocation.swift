/*
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import CoreLocation

struct EOLocation {
  enum GeometryType {
    case position
    case point
    case polygon

    static func fromString(string: String) -> GeometryType? {
      switch string {
        case "Point": return .point
        case "Position": return .position
        case "Polygon": return .polygon
        default: return nil
      }
    }
  }

  let type: GeometryType
  let date: Date?
  let coordinates: [CLLocationCoordinate2D]

  init?(json: [String: Any]) {
    guard let typeString = json["type"] as? String,
          let geoType = GeometryType.fromString(string: typeString),
          let coords = json["coordinates"] as? [Any],
          (coords.count % 2) == 0 else {
      return nil
    }
    if let dateString = json["date"] as? String {
      date = EONET.ISODateReader.date(from: dateString)
    } else {
      date = nil
    }
    type = geoType
    coordinates = stride(from: 0, to: coords.count, by: 2).flatMap { index in
      guard let lat = coords[index] as? Double,
          let long = coords[index + 1] as? Double else {
        return nil
      }
      return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
  }
}
