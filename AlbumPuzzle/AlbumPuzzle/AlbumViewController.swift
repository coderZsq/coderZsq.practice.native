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
        
        let authorized = PHPhotoLibrary.authorized.share()
        
        authorized.skipWhile { $0 == false }.take(1).subscribe(onNext: { [weak self] _ in
            self?.images = AlbumViewController.loadImages()
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
        }).addDisposableTo(bag)
        
        authorized.skip(1).takeLast(1).filter { $0 == false }.subscribe(onNext: { [weak self] _ in
            guard let errorMessage = self?.errorMessage else { return }
                DispatchQueue.main.async(execute: errorMessage)
        }).addDisposableTo(bag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectedImagesSubject.onCompleted()
    }
}

extension AlbumViewController {
    
    static func loadImages() -> PHFetchResult<PHAsset> {
        let allImagesOptions = PHFetchOptions()
        allImagesOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allImagesOptions)
    }
    
    fileprivate func errorMessage() {
        alert(title: "No access to Camera Roll",
              text: "You can grant access to Combinestagram from the Settings app")
            .take(5.0, scheduler: MainScheduler.instance)
            .subscribe(onDisposed: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
                _ = self?.navigationController?.popViewController(animated: true)
        }).addDisposableTo(bag)
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
