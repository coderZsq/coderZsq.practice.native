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

import Foundation

struct EOEvent {
  let id: String
  let title: String
  let description: String
  let link: URL?
  let closeDate: Date?
  let categories: [Int]
  let locations: [EOLocation]

  init?(json: [String: Any]) {
    guard let id = json["id"] as? String,
          let title = json["title"] as? String,
          let description = json["description"] as? String,
          let link = json["link"] as? String,
          let closeDate = json["closed"] as? String,
          let categories = json["categories"] as? [[String: Any]] else {
      return nil
    }
    self.id = id
    self.title = title
    self.description = description
    self.link = URL(string: link)
    self.closeDate = EONET.ISODateReader.date(from: closeDate)
    self.categories = categories.flatMap { categoryDesc in
      guard let catID = categoryDesc["id"] as? Int else {
        return nil
      }
      return catID
    }
    if let geometries = json["geometries"] as? [[String: Any]] {
      locations = geometries.flatMap(EOLocation.init)
    } else {
      locations = []
    }
  }

  static func compareDates(lhs: EOEvent, rhs: EOEvent) -> Bool {
    switch (lhs.closeDate, rhs.closeDate) {
      case (nil, nil): return false
      case (nil, _): return true
      case (_, nil): return false
      case (let ldate, let rdate): return ldate! < rdate!
    }
  }
}
