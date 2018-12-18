//
//  AnchorViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

private let kContentCellID = "kContentCellID"

class AnchorViewController: UIViewController {

    var homeType : HomeType!
    fileprivate lazy var homeVM : HomeViewModel = HomeViewModel()

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = WaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.dataSource = self
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: kContentCellID)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData(index: 0)
    }
}

extension AnchorViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

extension AnchorViewController {
    fileprivate func loadData(index : Int) {
        homeVM.loadHomeData(type: homeType, index : index, finishedCallback: {
            self.collectionView.reloadData()
        })
    }
}

extension AnchorViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath) as! HomeViewCell
        cell.anchorModel = homeVM.anchorModels[indexPath.item]
        if indexPath.item == homeVM.anchorModels.count - 1 {
            loadData(index: homeVM.anchorModels.count)
        }
        return cell
    }
}

extension AnchorViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let roomVc = RoomViewController()
        roomVc.view.backgroundColor = UIColor(r: 65, g: 65, b: 65)
        roomVc.anchor = homeVM.anchorModels[indexPath.item]
        navigationController?.pushViewController(roomVc, animated: true)
    }
}

extension AnchorViewController: WaterfallLayoutDataSource {
    
    func numberOfCols(_ waterfall: WaterfallLayout) -> Int {
        return 2
    }
    
    func waterfall(_ waterfall: WaterfallLayout, item: Int) -> CGFloat {
        return item % 2 == 0 ? kScreenW * 2 / 3 : kScreenW * 0.5
    }
    
}
