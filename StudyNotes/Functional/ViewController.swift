//
//  ViewController.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

struct City {
    let name: String
    let population: Int
}

extension City {
    func scalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreImage()
        higherOrderFunc()
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
    
    func higherOrderFunc() {
        let paris = City(name: "Paris", population: 2241)
        let madrid = City(name: "Madrid", population: 3165)
        let amsterdam = City(name: "Amsterdam", population: 827)
        let berlin = City(name: "Berlin", population: 3562)
        
        let cities = [paris, madrid, amsterdam, berlin]
        
        print(cities.filter {$0.population > 1000}
            .map{$0.scalingPopulation()}
            .reduce("City: Population") { result, c in
                return result + "\n" + "\(c.name): \(c.population)"
        })
        
        /* generic & any
        func noOp<T>(_ x: T) -> T {
            return x
        }
        
        func noOpAny(_ x: Any) -> Any {
            return x
        }
        
        func noOpAnyWrong(_ x: Any) -> Any {
            return 0
        }
        */
    }
}

