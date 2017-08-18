//
//  PHPhotoLibaray+rx.swift
//  AlbumPuzzle
//
//  Created by 双泉 朱 on 17/4/19.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import Foundation
import Photos
import RxSwift

extension PHPhotoLibrary {

    static var authorized: Observable<Bool> {
        return Observable.create { observer in

            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    observer.onNext(false)
                    requestAuthorization { newStatus in
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    }
                }
            }
            
            return Disposables.create()
        }
    }
}
