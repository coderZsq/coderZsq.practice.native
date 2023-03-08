//
//  String.swift
//  SwiftfulCrypto
//
//  Created by 朱双泉 on 2023/3/2.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
