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

struct EOCategory: Equatable {
  let id: Int
  let name: String
  let description: String
  let endpoint: String
  var events = [EOEvent]()

  init?(json: [String: Any]) {
    guard let id = json["id"] as? Int,
        let name = json["title"] as? String,
        let description = json["description"] as? String else {
      return nil
    }
    self.id = id
    self.name = name
    self.description = description
    self.endpoint = "\(EONET.categoriesEndpoint)/\(id)"
  }

  // MARK: - Equatable
  static func ==(lhs: EOCategory, rhs: EOCategory) -> Bool {
    return lhs.id == rhs.id
  }
}
