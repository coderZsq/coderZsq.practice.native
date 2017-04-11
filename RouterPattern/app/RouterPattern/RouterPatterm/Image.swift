//
//  Image.swift
//  RouterPatterm
//
//  Created by 双泉 朱 on 17/4/11.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadUrl(imageUrl: String?, placeholder: String = "placeholder") {
        self.kf.setImage(with: URL(string: imageUrl?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), placeholder: UIImage(named: placeholder), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
