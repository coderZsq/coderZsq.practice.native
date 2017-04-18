//
//  AlbumViewController.swift
//  AlbumPuzzle
//
//  Created by 双泉 朱 on 17/4/18.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import Photos
import RxSwift

private let reuseIdentifier = "Cell"

class AlbumViewController: UICollectionViewController {
    
    let bag = DisposeBag()
    var selectedImages: Observable<UIImage> {
        return selectedImagesSubject.asObservable()
    }
    
    fileprivate let selectedImagesSubject = PublishSubject<UIImage>()
    fileprivate lazy var images = AlbumViewController.loadImages()
    fileprivate lazy var imageManager = PHCachingImageManager()
    fileprivate lazy var thumbnailSize: CGSize = {
        let cellSize = (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize
        return CGSize(width: cellSize.width * UIScreen.main.scale,
                      height: cellSize.height * UIScreen.main.scale)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

extension AlbumViewController {
    
    static func loadImages() -> PHFetchResult<PHAsset> {
        let allImagesOptions = PHFetchOptions()
        allImagesOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allImagesOptions)
    }
}

extension AlbumViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let asset = images.object(at: indexPath.item)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            cell.layer.contents = image?.cgImage
        })
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let asset = images.object(at: indexPath.item)

        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                cell.alpha = 1
            })
        }

        imageManager.requestImage(for: asset, targetSize: view.frame.size, contentMode: .aspectFill, options: nil, resultHandler: { [weak self] image, info in
            guard let image = image, let info = info else { return }
            
            if let isThumbnail = info[PHImageResultIsDegradedKey as NSString] as? Bool, !isThumbnail {
                self?.selectedImagesSubject.onNext(image)
            }
        })
    }
}
