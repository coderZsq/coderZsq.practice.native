//
//  RxViewModel.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import RxSwift

class RxViewModel: NSObject {
    
    var rxObserable: Variable<[RxModel]> = {
        let path = Bundle.main.path(forResource: "rx.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var heros = [RxModel]()
        for dict in dataArray {
            heros.append(RxModel(dict: dict))
        }
        return Variable(heros)
    }()
    
}
