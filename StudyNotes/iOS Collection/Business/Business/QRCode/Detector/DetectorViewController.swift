//
//  DetectorViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DetectorViewController: UIViewController {

    @IBOutlet weak var sourceImageView: UIImageView!
    
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBAction func detectorQRCode(_ sender: UIButton) {
        if let sourceImage = sourceImageView.image {
            let (feature, image) = QRCodeTool.detectorQRCode(scourceImage: sourceImage, isDrawQRCodeFrame: true)
            print(feature)
            resultImageView.image = image
        }
//        let context = CIContext()
//        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
//        if
//            var image = sourceImageView.image,
//            let ciImage = CIImage(image: image),
//            let features = detector?.features(in: ciImage) {
//            for feature in features {
//                if let tempFeature = feature as? CIQRCodeFeature {
//                    print(tempFeature.bounds)
//                    print(tempFeature.messageString ?? "")
//                    image = drawQRCodeFrame(feature: tempFeature, toImage: image)!
//                    resultImageView.image = image
//                }
//            }
//        }
    }
    
//    func drawQRCodeFrame(feature: CIQRCodeFeature, toImage: UIImage) -> UIImage? {
//        let bounds = feature.bounds
//        let size = toImage.size
//        UIGraphicsBeginImageContext(size)
//        toImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//        let context = UIGraphicsGetCurrentContext()
//        context?.scaleBy(x: 1, y: -1)
//        context?.translateBy(x: 0, y: -size.height)
//        let path = UIBezierPath(rect: bounds)
//        path.lineWidth = 10
//        UIColor.red.set()
//        path.stroke()
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detector"
    }
}

