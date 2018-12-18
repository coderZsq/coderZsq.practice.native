//
//  UIImageView+Extension.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
//import GPUImage

extension UIImageView {
    
//    func blurImageNamed(_ name: String) {
//        guard let sourceImage = UIImage(named: name) else { return }
//        let picProcess = GPUImagePicture(image: sourceImage)
//        let blurFilter = GPUImageGaussianBlurFilter()
//        blurFilter.texelSpacingMultiplier = 5
//        blurFilter.blurRadiusInPixels = 5
//        picProcess?.addTarget(blurFilter)
//        blurFilter.useNextFrameForImageCapture()
//        picProcess?.processImage()
//        let newImage = blurFilter.imageFromCurrentFramebuffer()
//        self.image = newImage
//    }
    
//    func processImageNamed(_ name: String, filter: GPUImageFilter) {
//        let picProcess = GPUImagePicture(image: image)
//        picProcess?.addTarget(filter)
//        filter.useNextFrameForImageCapture()
//        picProcess?.processImage()
//        self.image = filter.imageFromCurrentFramebuffer()
//    }
    
    func gifImageNamed(_ name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "gif") else {
            return
        }
        guard let data = NSData(contentsOfFile: path) else { return }
        guard let imageSource = CGImageSourceCreateWithData(data, nil) else {
            return
        }
        let imageCount = CGImageSourceGetCount(imageSource)
        var images = [UIImage]()
        var totalDuration: TimeInterval = 0
        for i in 0..<imageCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else {
                continue
            }
            let image = UIImage(cgImage: cgImage)
            if i == 0 {
                self.image = image
            }
            images.append(image)
            guard let properties: NSDictionary = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) else { continue }
            guard let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary else { continue }
            guard let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        self.animationImages = images
        self.animationDuration = totalDuration
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
}
