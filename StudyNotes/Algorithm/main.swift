//
//  main.swift
//  Algorithm
//
//  Created by 朱双泉 on 26/02/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

public func timing(_ action: () -> ()) {
    let time = NSDate().timeIntervalSince1970
    action()
    print("timing: \(NSDate().timeIntervalSince1970 - time)")
}

public func randomList(_ num: UInt32) -> [Int] {
    var list = [Int]()
    for _ in 0..<num {
        list.append(Int(arc4random() % num) + 1)
    }
    return list;
}

scope(of: "sort", execute: false) {
        
    scope(of: "systemsort", execute: true, action: {
        let list = randomList(10000)
        timing {_ = list.sorted()}
//        print(list.sorted())
    })
    
    scope(of: "systemsort2", execute: true, action: {
        let list = randomList(10000)
        timing {_ = list.sorted {$0 < $1}}
//        print(list.sorted {$0 < $1})
    })
    
    scope(of: "selectsort", execute: true, action: {
        var list = randomList(10000)
        timing {selectSort(list: &list)}
//        print(list)
    })

    scope(of: "opt_selectsort", execute: true, action: {
        var list = randomList(10000)
        timing {optimizationSelectSort(list: &list)}
//        print(list)
    })

    scope(of: "popsort", execute: true, action: {
        var list = randomList(10000)
        timing {popSort(list: &list)}
//        print(list)
    })

    scope(of: "opt_popsort", execute: true, action: {
        var list = randomList(10000)
        timing {optimizationPopSort(list: &list)}
//        print(list)
    })

    scope(of: "quicksort", execute: true, action: {
        var list = randomList(10000)
        timing {quickSort(list: &list)}
//        print(list)
    })
}

scope(of: "search", execute: true) {
    
    scope(of: "binsearch", execute: true, action: {
        let list = randomList(10000)
        var index = 0
        timing {index = binSearch(list: list.sorted {$0 < $1}, find: 6)}
        print("index: \(index)")
    })
    
    scope(of: "rec_binsearch", execute: true, action: {
        let list = randomList(10000)
        var index = 0
        timing { index = recursiveBinSearch(list: list.sorted {$0 < $1}, find: 6)}
        print("index: \(index)")
    })
    
    scope(of: "findMedianSortedArrays", execute: true, action: {
        
        var array1 = randomList(1000000)
        var array2 = randomList(1000000)
        quickSort(list: &array1)
        quickSort(list: &array2)
        print(findMedianSortedArrays_1(array1, array2))
        print(findMedianSortedArrays_2(array1, array2))
        print(findMedianSortedArrays_3(array1, array2))
        
        scope(of: "findMedianSortedArrays_1", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_1(array1, array2) }
        })
        
        scope(of: "findMedianSortedArrays_2", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_2(array1, array2) }
        })
        
        scope(of: "findMedianSortedArrays_3", execute: true, action: {
            var array1 = randomList(1000000)
            var array2 = randomList(1000000)
            quickSort(list: &array1)
            quickSort(list: &array2)
            timing { findMedianSortedArrays_3(array1, array2) }
        })
    })
}

scope(of: "math", execute: true) {
    
    scope(of: "pow", execute: true, action: {
        print(_pow_1(3, 4))
        print(_pow_2(3, 4))
        print(_pow_3(3, 4))
    })
}
