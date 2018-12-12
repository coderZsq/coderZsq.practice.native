//
//  KingfisherExtension.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ URLString : String?, _ placeHolderName : String?) {
        guard let URLString = URLString else {
            return
        }
        
        guard let placeHolderName = placeHolderName else {
            return
        }
        
        guard let url = URL(string: URLString) else { return }
        kf.setImage(with: url, placeholder : UIImage(named: placeHolderName))
    }
}
