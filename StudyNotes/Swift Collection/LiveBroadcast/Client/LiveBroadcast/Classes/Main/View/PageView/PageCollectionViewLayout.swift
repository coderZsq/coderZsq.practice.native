//
//  PageCollectionViewLayout.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class PageCollectionViewLayout: UICollectionViewFlowLayout {
    var cols = 4
    var rows = 2
    fileprivate lazy var cellAttrs = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxWidth: CGFloat = 0
}

extension PageCollectionViewLayout {
    
    override func prepare() {
        super.prepare()
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        let sectionCount = collectionView!.numberOfSections
        var prePageCount : Int = 0
        for i in 0..<sectionCount {
            let itemCount = collectionView!.numberOfItems(inSection: i)
            for j in 0..<itemCount {
                let indexPath = IndexPath(item: j, section: i)
                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let page = j / (cols * rows)
                let index = j % (cols * rows)
                let itemY = sectionInset.top + (itemH + minimumLineSpacing) * CGFloat(index / cols)
                let itemX = CGFloat(prePageCount + page) * collectionView!.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing) * CGFloat(index % cols)
                attr.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                cellAttrs.append(attr)
            }
            prePageCount += (itemCount - 1) / (cols * rows) + 1
        }
        maxWidth = CGFloat(prePageCount) * collectionView!.bounds.width
    }
    
}

extension PageCollectionViewLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    
}

extension PageCollectionViewLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWidth, height: 0)
    }

}
