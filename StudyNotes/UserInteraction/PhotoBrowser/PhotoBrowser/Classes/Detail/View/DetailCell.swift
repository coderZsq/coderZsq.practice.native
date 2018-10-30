//
//  DetailCell.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var model: ProductModel? {
        didSet {
            if let url = URL(string: model?.hd_thumb_url ?? "") {
                imageView.sd_setImage(with: url)
            }
        }
    }
}
