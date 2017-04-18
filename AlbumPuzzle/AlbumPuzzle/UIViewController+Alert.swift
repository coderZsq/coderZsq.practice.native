//
//  UIViewController+Alert.swift
//  AlbumPuzzle
//
//  Created by 双泉 朱 on 17/4/18.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import RxSwift

extension UIViewController {
    
    func alert(title: String, text: String?) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Close", style: .default, handler: {_ in
                observer.onCompleted()
            }))
            self?.present(alertVC, animated: true, completion: nil)
            return Disposables.create {
                self?.dismiss(animated: true, completion: nil)
            }
        }
    }
}
