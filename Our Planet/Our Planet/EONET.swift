//
//  EONET.swift
//  Our Planet
//
//  Created by 双泉 朱 on 17/4/20.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EONET {
    
    fileprivate static let API = "https://eonet.sci.gsfc.nasa.gov/api/v2.1"
    static let categoriesEndpoint = "/categories"
    fileprivate static let eventsEndpoint = "/events"

    static var ISODateReader: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return formatter
    }()

    static var categories: Observable<[EOCategory]> = {
        return EONET.request(endpoint: categoriesEndpoint)
            .map { data in
                let categories = data["categories"] as? [[String: Any]] ?? []
                return categories
                    .flatMap(EOCategory.init)
                    .sorted { $0.name < $1.name }
            }
            .shareReplay(1)
    }()
    
    
}

extension EONET {

    fileprivate static func request(endpoint: String, query: [String : Any] = [:]) -> Observable<[String : Any]> {
    
        do {
            guard let url = URL(string: API)?.appendingPathComponent(endpoint), var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                throw EOError.invalidURL(endpoint)
            }
            
            components.queryItems = try query.flatMap { (key, value) in
                guard let v = value as? CustomStringConvertible else {
                    throw EOError.invalidParameter(key, value)
                }
                return URLQueryItem(name: key , value: v.description)
            }
            
            guard let finalURL = components.url else {
                throw EOError.invalidURL(endpoint)
            }
            
            let request = URLRequest(url: finalURL)
            return URLSession.shared.rx.response(request: request).map { _, data -> [String : Any] in
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []), let result = jsonObject as? [String : Any] else {
                    throw EOError.invalidJSON(finalURL.absoluteString)
                }
                return result
            }
        } catch {
            return Observable.empty()
        }
    }
    
    fileprivate static func events(forLast days: Int, closed: Bool, endpoint: String) -> Observable<[EOEvent]> {
        
        return request(endpoint: eventsEndpoint, query: [
            "days": NSNumber(value: days),
            "status": (closed ? "closed" : "open")
        ]).map { json in
            guard let raw = json["events"] as? [[String : Any]] else {
                throw EOError.invalidJSON(endpoint)
            }
            return raw.flatMap(EOEvent.init)
        }
    }
    
    static func events(forLast days: Int = 360, category: EOCategory) -> Observable<[EOEvent]> {

        let openEvents = events(forLast: days, closed: false, endpoint: category.endpoint)
        let closedEvents = events(forLast: days, closed: true, endpoint: category.endpoint)
        
        return Observable.of(openEvents, closedEvents).merge().reduce([]) { running, new in
            running + new
        }
    }
    
    
    static func filteredEvents(events: [EOEvent], forCategory category: EOCategory) -> [EOEvent] {
        return events.filter { event in
            return event.categories.contains(category.id) &&
                !category.events.contains {
                    $0.id == event.id
                }
            }.sorted(by: EOEvent.compareDates)
    }
}

