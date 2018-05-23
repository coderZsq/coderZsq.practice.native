//
//  LinearSearch.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

//n
func linearSearch<T: Equatable>(_ array: [T], _ object: T) -> Int? {
    for (index, obj) in array.enumerated() where obj == object {
        return index
    }
    return nil
}
