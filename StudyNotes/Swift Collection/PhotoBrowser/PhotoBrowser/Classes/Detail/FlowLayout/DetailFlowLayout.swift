//
//  DetailFlowLayout.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DetailFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        itemSize = kScreenSize
        scrollDirection = .horizontal
        minimumLineSpacing = 10
        collectionView?.isPagingEnabled = true
    }
}
