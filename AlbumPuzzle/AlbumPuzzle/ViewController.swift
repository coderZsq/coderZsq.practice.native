//
//  ViewController.swift
//  AlbumPuzzle
//
//  Created by 双泉 朱 on 17/4/17.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var itemAdd: UIBarButtonItem!
    
    fileprivate let bag = DisposeBag()
    fileprivate let images = Variable<[UIImage]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservable()
    }
}

extension ViewController {
    
    fileprivate func setupObservable() {
        
        images.asObservable().subscribe(onNext: { [weak self] images in
            guard let preview = self?.imagePreview else { return }
            preview.image = UIImage.collage(images: images, size: preview.frame.size)
            }).addDisposableTo(bag)
        
        images.asObservable().subscribe(onNext: { [weak self] images in
            self?.updateUI(images: images)
        }).addDisposableTo(bag)
    }
    
    fileprivate func updateUI(images: [UIImage]) {
        buttonSave.isEnabled = images.count > 0 && images.count % 2 == 0
        buttonClear.isEnabled = images.count > 0
        itemAdd.isEnabled = images.count < 6
        title = images.count > 0 ? "\(images.count) photos" : "Collage"
    }
    
    fileprivate func showMessage(_ title: String, description: String? = nil) {
        alert(title: title, text: description).subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }
        ).addDisposableTo(bag)
    }
}


extension ViewController {
    
    @IBAction func actionAdd() {
//        images.value.append(UIImage(named: "Castie!")!)
        
        let albumViewController = storyboard?.instantiateViewController(withIdentifier: "AlbumViewController") as! AlbumViewController
        
        albumViewController.selectedImages.subscribe(
            onNext: { [weak self] newImage in
                guard let images = self?.images else { return }
                images.value.append(newImage)
            },
            onDisposed: {
                print("completed photo selection")
            }
        ).addDisposableTo(albumViewController.bag)
        
        navigationController?.pushViewController(albumViewController, animated: true)
    }
    
    @IBAction func actionClear() {
        images.value = []
    }
    
    
    @IBAction func actionSave() {
        
        guard let image = imagePreview.image else { return }
        
        AlbumWriter.save(image).subscribe(
            
            onError: { [weak self] error in
            self?.showMessage("Error", description: error.localizedDescription)
            
            }, onCompleted: { [weak self] in
                self?.showMessage("Saved")
                self?.actionClear()
            }
            
        ).addDisposableTo(bag)
    }
}

