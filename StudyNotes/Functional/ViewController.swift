//
//  ViewController.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreImage()
    }
}

extension ViewController {
    
    func coreImage() {
        let url = URL(string: "http://via.placeholder.com/500x500")!
        let image = CIImage(contentsOf: url)!
        
        let radius = 5.0
        let color = UIColor.red.withAlphaComponent(0.2)
//        let blurredImage = blur(radius: radius)(image)
//        let overlaidImage = overlay(color: color)(blurredImage)
//
//        let result = overlay(color: color)(blur(radius: radius)(image))
        
//        let blurAndOverlay = compose(filter: blur(radius: radius), with: overlay(color: color))
//        let result1 = blurAndOverlay(image)

        let blurAndOverlay2 = blur(radius: radius) >>> overlay(color: color)
        let result2 = blurAndOverlay2(image)
        
        imageView.image = UIImage(ciImage: result2)
        
        /* curry
        func add1(_ x: Int, y: Int) -> Int {
            return x + y
        }
        
        func add2(_ x: Int) -> ((Int) -> Int) {
            return { y in x + y }
        }
        
        add1(1, y: 2)
        add2(1)(2)
        */
    }
}
