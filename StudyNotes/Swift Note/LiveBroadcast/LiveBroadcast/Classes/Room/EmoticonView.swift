//
//  EmoticonView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

private let kEmoticonCellID = "kEmoticonCellID"

class EmoticonView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmoticonView {
    
    fileprivate func setupUI() {
        let style = TitleStyle()
        style.isShowScrollLine = true
        let layout = PageCollectionViewLayout()
        layout.cols = 7
        layout.rows = 3
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let pageCollectionView = PageCollectionView(frame: bounds, titles: ["普通", "粉丝专属"], isTitleInTop: false, style: style, layout: layout)
        addSubview(pageCollectionView)
        pageCollectionView.dataSource = self
        pageCollectionView.register(nib: UINib(nibName: "EmoticonViewCell", bundle: nil), identifier: kEmoticonCellID)
    }
    
}

extension EmoticonView: PageCollectionViewDataSource {
    
    func numberOfSections(in pageCollectionView: PageCollectionView) -> Int {
        return EmoticonViewModel.shared.packages.count
    }
    
    func pageCollectionView(_ collectionView: PageCollectionView, numberOfItemsInSection section: Int) -> Int {
        return EmoticonViewModel.shared.packages[section].emoticons.count
    }
    
    func pageCollectionView(_ pageCollectionView: PageCollectionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCellID, for: indexPath) as! EmoticonViewCell
        cell.emoticon = EmoticonViewModel.shared.packages[indexPath.section].emoticons[indexPath.row]
        return cell
    }
    
}
