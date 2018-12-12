//
//  GiftListView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

private let kGiftCellID = "kGiftCellID"

protocol GiftListViewDelegate : class {
    func giftListView(giftView : GiftListView, giftModel : GiftModel)
}

class GiftListView: UIView, NibLoadable {
    @IBOutlet weak var giftView: UIView!
    @IBOutlet weak var sendGiftBtn: UIButton!
    
    fileprivate var pageCollectionView : PageCollectionView!
    fileprivate var currentIndexPath : IndexPath?
    fileprivate var giftVM : GiftViewModel = GiftViewModel()
    
    weak var delegate : GiftListViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGiftView()
        loadGiftData()
    }
}

extension GiftListView {
    fileprivate func setupUI() {
        setupGiftView()
    }
    
    fileprivate func setupGiftView() {
        let style = TitleStyle()
        style.isScrollEnable = false
        style.isShowScrollLine = true
        style.normalColor = UIColor(r: 255, g: 255, b: 255)
        
        let layout = PageCollectionViewLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.cols = 4
        layout.rows = 2
        
        var pageViewFrame = giftView.bounds
        pageViewFrame.size.width = kScreenW
        pageCollectionView = PageCollectionView(frame: pageViewFrame, titles: ["热门", "高级", "豪华", "专属"], isTitleInTop: true, style: style, layout : layout)
        giftView.addSubview(pageCollectionView)
        
        pageCollectionView.dataSource = self
        pageCollectionView.delegate = self
        
        pageCollectionView.register(nib: UINib(nibName: "GiftViewCell", bundle: nil), identifier: kGiftCellID)
    }
}

extension GiftListView {
    fileprivate func loadGiftData() {
        giftVM.loadGiftData {
            self.pageCollectionView.reloadData()
        }
    }
}

extension GiftListView : PageCollectionViewDataSource, PageCollectionViewDelegate {
    
    func numberOfSections(in pageCollectionView: PageCollectionView) -> Int {
        return giftVM.giftlistData.count
    }
    
    func pageCollectionView(_ collectionView: PageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let package = giftVM.giftlistData[section]
        return package.list.count
    }
    
    func pageCollectionView(_ pageCollectionView: PageCollectionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGiftCellID, for: indexPath) as! GiftViewCell
        
        let package = giftVM.giftlistData[indexPath.section]
        cell.giftModel = package.list[indexPath.item]
        
        return cell
    }
    
    func pageCollectionView(_ pageCollectionView: PageCollectionView, didSelectItemAt indexPath: IndexPath) {
        sendGiftBtn.isEnabled = true
        currentIndexPath = indexPath
    }
}

extension GiftListView {
    @IBAction func sendGiftBtnClick() {
        let package = giftVM.giftlistData[currentIndexPath!.section]
        let giftModel = package.list[currentIndexPath!.item]
        delegate?.giftListView(giftView: self, giftModel: giftModel)
    }
}
