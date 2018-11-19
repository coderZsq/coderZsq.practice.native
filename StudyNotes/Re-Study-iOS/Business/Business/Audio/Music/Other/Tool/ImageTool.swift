//
//  ImageTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ImageTool: NSObject {

    class func getImage(sourceImage: UIImage?, text: String?) -> UIImage {
        if text == "" {
            return sourceImage ?? UIImage()
        }
        guard let text = text else {
            return sourceImage ?? UIImage()
        }
        guard let sourceImage = sourceImage else {
            return UIImage()
        }
        UIGraphicsBeginImageContext(sourceImage.size)
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: sourceImage.size.width, height: sourceImage.size.height))
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        let attributes = [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.paragraphStyle: style
        ]
        (text as NSString).draw(in: CGRect(x: 0, y: 0, width: sourceImage.size.width, height: 28), withAttributes: attributes)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}
