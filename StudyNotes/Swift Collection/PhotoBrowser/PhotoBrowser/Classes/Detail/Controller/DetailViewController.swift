//
//  DetailViewController.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "DetailCell"

class DetailViewController: UIViewController {

    var models: [ProductModel] = []
    
    var scrollIndexPath: IndexPath?
    
    var currentRow: Int {
        let row = collectionView.indexPathsForVisibleItems.first?.row ?? 0
        return row
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let indexPath = scrollIndexPath {
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
    }
}

extension DetailViewController {
    
    func registerCell() {
        let nib = UINib(nibName: "DetailCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    @IBAction func closeButtonClick(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailCell
        cell.model = models[indexPath.row]
        return cell
    }
}
