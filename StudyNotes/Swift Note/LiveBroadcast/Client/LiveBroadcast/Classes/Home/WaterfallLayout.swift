//
//  WaterfallLayout.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDataSource: class {
    func numberOfCols(_ waterfall: WaterfallLayout) -> Int
    func waterfall(_ waterfall: WaterfallLayout, item: Int) -> CGFloat
}

class WaterfallLayout: UICollectionViewFlowLayout {
    weak var dataSource: WaterfallLayoutDataSource?
    fileprivate lazy var cellAttrs = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var cols: Int = {
        return self.dataSource?.numberOfCols(self) ?? 3
    }()
    fileprivate lazy var totalHeights = Array(repeating: sectionInset.top, count: cols)
}

extension WaterfallLayout {
    
    override func prepare() {
        super.prepare()
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        let cellW: CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        for i in cellAttrs.count..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            guard let cellH: CGFloat = dataSource?.waterfall(self, item: i) else {
                fatalError("Error:\(#line) waterfall(_ waterfall: WaterfallLayout, item: Int)")
            }
            let minH = totalHeights.min()!
            let minIndex = totalHeights.index(of: minH)!
            let cellX: CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY: CGFloat = minH
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            cellAttrs.append(attr)
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
        }
    }

}

extension WaterfallLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    
}

extension WaterfallLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: totalHeights.max()! + sectionInset.bottom - minimumLineSpacing)
    }
    
}
