//
//  ViewController.swift
//  UIAlgorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

extension UIColor {
    var toImage: UIImage {
        let bounds = CGRect(origin: .zero, size: CGSize(width: 1.0, height: 1.0))
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            self.setFill()
            context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}

extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var lights: [UIButton]! {
        didSet {
            for (index, light) in lights.enumerated() {
                light.setBackgroundImage(UIColor.yellow.toImage, for: .normal)
                light.setBackgroundImage(UIColor.darkGray.toImage, for: .selected)
                light.isSelected = switchs.lights[index] == 1 ? true : false
            }
        }
    }
    
    @IBAction func lightUp(_ sender: UIButton) {
        switchs.lightUp(index: lights.index(of: sender))
        for (index, light) in lights.enumerated() {
            light.isSelected = switchs.lights[index] == 1 ? true : false
        }
        if Set(switchs.lights).count == 1 {
            let alert = UIAlertController(title: "Congratulation", message: "You made all light up successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "again",
                style: .default,
                handler: { [weak self] _ in
                    self?.restart()
                }
            ))
            present(alert, animated: true)
        }
    }
    
    @IBAction func restart(_ sender: UIButton? = nil) {
        switchs = LightSwitch(matrix: Matrix(rows: 5, columns: 6))
        for (index, light) in (self.lights.enumerated()) {
            light.isSelected = self.switchs.lights[index] == 1 ? true : false
        }
    }
    
    @IBOutlet weak var hintButton: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Hint", let destination = segue.destination.contents as? HintViewController,
            let ppc = destination.popoverPresentationController {
            ppc.delegate = self
            ppc.sourceRect = hintButton.bounds
            destination.switchs = switchs
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    
    var switchs: LightSwitch = LightSwitch(matrix: Matrix(rows: 5, columns: 6))
}

