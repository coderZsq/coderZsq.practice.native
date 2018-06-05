//
//  EncodingAndDecoding.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/5.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation
import CoreLocation

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
            {"name" : "Berlin"}
            {"name" : "Cape Town"}
        ]
        """
        
        let invalidJSONInput = """
        [
            {
            "name" : "Berlin"
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
// ?
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
