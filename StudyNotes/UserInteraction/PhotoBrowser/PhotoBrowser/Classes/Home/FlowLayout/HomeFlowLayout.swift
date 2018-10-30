//
//  HomeFlowLayout.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class HomeFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        let itemCountInRow: CGFloat = 3
        let margin: CGFloat = 10
        let itemW = (kScreenW - (itemCountInRow + 1) * margin) / itemCountInRow
        let itemH = itemW * 1.3
        itemSize = CGSize(width: itemW, height: itemH)
        minimumLineSpacing = margin
        minimumInteritemSpacing = margin
        collectionView?.contentInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}
