//
//  HomeViewController.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "HomeCell"

class HomeViewController: UICollectionViewController {
    
    var currentPage = 1
    
    weak var detailViewController: DetailViewController?
    
    lazy var animation: HomeAnimation = {
        $0.presentDelegate = self
        $0.dismissDelegate = self
        return $0
    }(HomeAnimation())
    
    var models: [ProductModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

extension HomeViewController {
    
    func loadData() {
        HomeDataTool.requestHomeDataList { (models) in
            self.models = models
        }
    }
    
    func loadMoreData() {
        let requestPage = currentPage + 1
        HomeDataTool.requestHomeDataList(page: currentPage) { (models) in
            self.models += models
            if models.count != 0 {
                self.currentPage = requestPage
            }
        }
    }
}

extension HomeViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductCell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let pCell = cell as! ProductCell
        pCell.model = models[indexPath.row]
        if indexPath.row == models.count - 1 {
            loadMoreData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        self.detailViewController = detailViewController
        detailViewController.models = models
        detailViewController.scrollIndexPath = indexPath
//        detailViewController.modalTransitionStyle = .flipHorizontal
        detailViewController.modalPresentationStyle = .custom
        detailViewController.transitioningDelegate = animation
        present(detailViewController, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeAnimationPresentDelegate {
    
    func presentAnimationView() -> UIView {
        guard let currentIndexPath = collectionView?.indexPathsForSelectedItems?.first else {
            return UIView()
        }
        let imageView = UIImageView()
        let model = models[currentIndexPath.row]
        if let url = URL(string: model.thumb_url) {
            imageView.sd_setImage(with: url)
            return imageView
        }
        return UIView()
    }
    
    func presentAnimationFromFrame() -> CGRect {
        guard let currentIndexPath = collectionView?.indexPathsForSelectedItems?.first else {
            return .zero
        }
        guard let cell = collectionView.cellForItem(at: currentIndexPath) else {
            return .zero
        }
        let window = UIApplication.shared.keyWindow
        let resultFrame = collectionView.convert(cell.frame, to: window)
        return resultFrame
    }
    
    func presentAnimationToFrame() -> CGRect {
        return kScreenBounds
    }
}

extension HomeViewController: HomeAnimationDismissDelegate {
    
    func dismissAnimationView() -> UIView {
        let imageView = UIImageView()
        let model = models[self.detailViewController?.currentRow ?? 0]
        if let url = URL(string: model.hd_thumb_url) {
            imageView.sd_setImage(with: url)
            return imageView
        }
        return UIView()
    }
    
    func dismissAnimationFromFrame() -> CGRect {
        return kScreenBounds
    }
    
    func dismissAnimationToFrame() -> CGRect {
        let currentRow = self.detailViewController?.currentRow ?? 0
        let currentIndexPath = IndexPath(row: currentRow, section: 0)
        guard let cell = collectionView.cellForItem(at: currentIndexPath) else {
            var currentVisibleIndexPath = collectionView.indexPathsForVisibleItems
            currentVisibleIndexPath.sort { (first, second) -> Bool in
                return first.row < second.row
            }
            let minRow = currentVisibleIndexPath.first?.row ?? 0
//            let maxRow = currentVisibleIndexPath.last?.row ?? 0
            if currentRow < minRow {
                return .zero
            } else {
                return CGRect(x: kScreenW, y: kScreenH, width: 0, height: 0);
            }
        }
        let window = UIApplication.shared.keyWindow
        let resultFrame = collectionView.convert(cell.frame, to: window)
        return resultFrame
    }
}
