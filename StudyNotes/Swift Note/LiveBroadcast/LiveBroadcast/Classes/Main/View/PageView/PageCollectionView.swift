//
//  PageCollectionView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class PageCollectionView: UIView {

    fileprivate var titles: [String]
    fileprivate var isTitleInTop: Bool
    fileprivate var layout: UICollectionViewFlowLayout
    
    init(frame: CGRect, titles: [String], isTitleInTop: Bool, layout: UICollectionViewFlowLayout) {
        self.titles = titles
        self.isTitleInTop = isTitleInTop
        self.layout = layout
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageCollectionView {
    
    fileprivate func setupUI() {
        
    }
}
