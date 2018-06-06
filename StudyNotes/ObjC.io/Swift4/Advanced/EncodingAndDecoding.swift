//
//  EncodingAndDecoding.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

struct EncodingAndDecoding {
    
    static func run() {
        
        let places = [
            Placemark(name: "Berlin", coordinate: Coordinate(latitude: 52, longitude: 13)),
            Placemark(name: "Cape Town", coordinate: Coordinate(latitude: -34, longitude: 18))
        ]
        
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(places)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
        } catch {
            print(error.localizedDescription)
        }
        
        do {
            let decoder = JSONDecoder()
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(places)
            let decoded = try decoder.decode([Placemark].self, from: jsonData)
            print(type(of: decoded))
            print(decoded == places)
        } catch {
            print(error.localizedDescription)
        }
        
        let validJSONInput = """
        [
            {"name" : "Berlin"},
            {"name" : "Cape Town"}
        ]
        """
        
        let invalidJSONInput = """
        [
            {
            "name" : "Berlin",
            "coordinate" : {}
            }
        ]
        """
        
        do {
            let inputData = invalidJSONInput.data(using: .utf8)!
            let decoder = JSONDecoder()
            let decoded = try decoder.decode([Placemark4].self, from: inputData)
            print(decoded)
        } catch {
            print(error.localizedDescription)
        }
        
        let colors: [UIColor] = [
            .red,
            .white,
            .init(displayP3Red: 0.5, green: 0.4, blue: 1.0, alpha: 0.8),
            .init(hue: 0.6, saturation: 1.0, brightness: 0.8, alpha: 0.9)
        ]
        
        let codabaleColors = colors.map(UIColor.CodableWrapper.init)
        
        let rects = [ColoredRect(rect: CGRect(x: 10, y: 20, width: 100, height: 200), color: .yellow)]
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(rects)
            let jsonString = String(decoding: jsonData, as: UTF8.self)
            print(jsonString)
        } catch {
            print(error.localizedDescription)
        }
        
        let values: [Either<String, Int>] = [
            .left("Forty-two"),
            .right(42)
        ]
        
        do {
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            let xmlData = try encoder.encode(values)
            let xmlString = String(decoding: xmlData, as: UTF8.self)
            print(xmlString)
            let decoder = PropertyListDecoder()
            let decoded = try decoder.decode([Either<String, Int>].self, from: xmlData)
            print(decoded)
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct Coordinate: Codable {
    var latitude: Double
    var longitude: Double
}

struct Placemark: Codable {
    var name: String
    var coordinate: Coordinate
}

extension Coordinate: Equatable {
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Placemark: Equatable {
    static func == (lhs: Placemark, rhs: Placemark) -> Bool {
        return lhs.name == rhs.name && lhs.coordinate == rhs.coordinate
    }
}

extension Array: Encodable where Element: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for element in self {
            try container.encode(element)
        }
    }
}

extension Placemark {
    private enum CodingKeys: CodingKey {
        case name
        case coordinate
    }
}
#if false
extension Placemark: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(coordinate, forKey: .coordinate)
    }
}

extension Placemark: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        coordinate = try container.decode(Coordinate.self, forKey: .coordinate)
    }
}
#endif
struct Placemark2: Codable {
    var name: String
    var coordinate: Coordinate
    
    private enum CodingKeys: String, CodingKey {
        case name = "label"
        case coordinate
    }
}

struct Placemark3: Codable {
    var name: String = "(Unknown)"
    var coordinate: Coordinate
    
    private enum CodingKeys: CodingKey {
        case coordinate
    }
    
}

struct Placemark4: Codable {
    var name: String
    var coordinate: Coordinate?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        do {
            self.coordinate = try container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        } catch DecodingError.keyNotFound {
            self.coordinate = nil
        }
    }
}

struct Placemark5: Codable {
    var name: String
    var coordinate: CLLocationCoordinate2D
}
//Implementation of 'Decodable' cannot be automatically synthesized in an extension
//extension CLLocationCoordinate2D: Codable {
//
//}

extension Placemark5 {
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.coordinate = CLLocationCoordinate2D(latitude: try container.decode(Double.self, forKey: .latitude), longitude: try container.decode(Double.self, forKey: .longitude))
    }
}

struct Placemark6: Encodable {
    var name: String
    var coordinate: CLLocationCoordinate2D
    
    private enum CodingKeys: CodingKey {
        case name
        case coordinate
    }
    
    private enum CoordinateCodingKeys: CodingKey {
        case latitude
        case longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var coordinateContainer = container.nestedContainer(keyedBy: CoordinateCodingKeys.self, forKey: .coordinate)
        try coordinateContainer.encode(coordinate.latitude, forKey: .latitude)
        try coordinateContainer.encode(coordinate.longitude, forKey: .longitude)
    }
}

struct Placemark7: Codable {
    var name: String
    private var _coordinate: Coordinate
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: _coordinate.longitude, longitude: _coordinate.longitude)
        }
        set {
            _coordinate = Coordinate(latitude: newValue.latitude, longitude: newValue.longitude)
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case _coordinate = "coordinate"
    }
}
/*
extension UIColor: Decodable {
    private enum CodingKeys: CodingKey {
        case red
        case green
        case blue
        case alpha
    }
    
    public init(from decoder: Decoder) {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(CGFloat.self, forKey: .red)
        let green = try container.decode(CGFloat.self, forKey: .green)
        let blue = try container.decode(CGFloat.self, forKey: .blue)
        let alpha = try container.decode(CGFloat.self, forKey: .alpha)
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func decodeDynamic(_ colorType: UIColor.Type, from decoder: Decoder) throws -> UIColor {
        return try colorType.init(from: decoder)
    }
    
    let color = decodeDynamic(SomeUIColorSubclass.self, from: someDecoder)
}
*/

extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return nil
        }
    }
}

extension UIColor {
    struct CodableWrapper: Codable {
        var value: UIColor
        
        init(_ value: UIColor) {
            self.value = value
        }
        
        enum CodingKeys: CodingKey {
            case red
            case green
            case blue
            case alpha
        }
        
        func encode(to encoder: Encoder) throws {
            guard let (red, green, blue, alpha) = value.rgba else {
                let errorContext = EncodingError.Context(codingPath: encoder.codingPath, debugDescription: "Unsupported color format: \(value)")
                throw EncodingError.invalidValue(value, errorContext)
            }
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(red, forKey: .red)
            try container.encode(green, forKey: .green)
            try container.encode(blue, forKey: .blue)
            try container.encode(alpha, forKey: .alpha)
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let red = try container.decode(CGFloat.self, forKey: .red)
            let green = try container.decode(CGFloat.self, forKey: .green)
            let blue = try container.decode(CGFloat.self, forKey: .blue)
            let alpha = try container.decode(CGFloat.self, forKey: .alpha)
            self.value = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
}

#if false
struct ColoredRect: Codable {
    var rect: CGRect
    var color: UIColor
}
#endif

struct ColoredRect: Codable {
    var rect: CGRect
    private var _color: UIColor.CodableWrapper
    var color: UIColor {
        get {return _color.value}
        set {_color.value = newValue}
    }
    
    init(rect: CGRect, color: UIColor) {
        self.rect = rect
        self._color = UIColor.CodableWrapper(color)
    }
    
    private enum CodingKeys: String, CodingKey {
        case rect
        case _color = "color"
    }
}

enum Either<A: Codable, B: Codable>: Codable {
    case left(A)
    case right(B)
    
    private enum CodingKeys: CodingKey {
        case left
        case right
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .left(let value):
            try container.encode(value, forKey: .left)
        case .right(let value):
            try container.encode(value, forKey: .right)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let leftVlaue = try container.decodeIfPresent(A.self, forKey: .left) {
            self = .left(leftVlaue)
        } else {
            let rightValue = try container.decode(B.self, forKey: .right)
            self = .right(rightValue)
        }
    }
}

//enum View {
//    case view(UIView)
//    case label(UILabel)
//    case imageView(UIImageView)
//}
