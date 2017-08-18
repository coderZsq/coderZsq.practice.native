//
//  AlbumWriter.swift
//  AlbumPuzzle
//
//  Created by 双泉 朱 on 17/4/18.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit
import RxSwift

class AlbumWriter: NSObject {
    
    typealias Callback = (NSError?)->Void
    
    private var callback: Callback
    private init(callback: @escaping Callback) {
        self.callback = callback
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        callback(error)
    }
    
    static func save(_ image: UIImage) -> Observable<Void> {
        return Observable.create({ observer in
            let writer = AlbumWriter(callback: { error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onCompleted()
                }
            })
            UIImageWriteToSavedPhotosAlbum(image, writer, #selector(AlbumWriter.image(_:didFinishSavingWithError:contextInfo:)), nil)
            return Disposables.create()
        })
    }
}
