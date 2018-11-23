//
//  GenerationViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class GenerationViewController: UIViewController {
    
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Generation"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let content = contentTextView.text {
            qrCodeImageView.image = QRCodeTool.generatorQRCode(content: content, bigImageSize: 200, smallIcon: UIImage(named: "Castiel"), smallImageSize: 44)
        }
//        let str = contentTextView.text
//        let strData = str?.data(using: .utf8)
//        let filter = CIFilter(name: "CIQRCodeGenerator")
//        filter?.setDefaults()
//        filter?.setValue(strData, forKey: "inputMessage")
//        //纠错率 L, M, Q, H
//        filter?.setValue("M", forKey: "inputCorrectionLevel")
//        if let ciImage = filter?.outputImage {
//            let image = createBigImage(image: ciImage, size: 200)
//            let smallImage = UIImage(named: "Castiel")
//            qrCodeImageView.image = createImage(bigImage: image, smallImage: smallImage, sizeHW: 44)
//        }
    }
    
//    func createImage(bigImage: UIImage?, smallImage: UIImage?, sizeHW: CGFloat) -> UIImage? {
//        if
//            let size = bigImage?.size,
//            let bigImage = bigImage,
//            let smallImage = smallImage {
//            UIGraphicsBeginImageContext(size)
//            bigImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//            let x = (size.width - sizeHW) * 0.5
//            let y = (size.height - sizeHW) * 0.5
//            smallImage.draw(in: CGRect(x: x, y: y, width: sizeHW, height: sizeHW))
//            let image = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return image
//        }
//       return nil
//    }
//
//    private func createBigImage(image: CIImage, size: CGFloat) -> UIImage? {
//        let extent = image.extent.integral
//        let scale = min(size / extent.width, size / extent.height)
//        let width = extent.width * scale
//        let height = extent.height * scale
//        let space = CGColorSpaceCreateDeviceGray()
//        if let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: 0) {
//            bitmapRef.interpolationQuality = .none
//            bitmapRef.scaleBy(x: scale, y: scale)
//            let context = CIContext(options: nil)
//            if let bitmapImage = context.createCGImage(image, from: extent) {
//                bitmapRef.draw(bitmapImage, in: extent)
//            }
//            if let scaledImage = bitmapRef.makeImage() {
//                return UIImage(cgImage: scaledImage)
//            }
//        }
//        return nil
//    }
}
