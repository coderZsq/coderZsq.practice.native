//
//  HintViewController.swift
//  UIAlgorithm
//
//  Created by 朱双泉 on 2018/5/19.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class HintViewController: UIViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let fittedSize = topLevelView?.sizeThatFits(UILayoutFittingCompressedSize) {
            preferredContentSize = CGSize(width: fittedSize.width + 30, height: fittedSize.height + 30)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if presentationController is UIPopoverPresentationController {
            view.backgroundColor = .clear
        }        
    }
    @IBOutlet var hints: [UIButton]! {
        didSet {
            for (index, hint) in hints.enumerated() {
                hint.setBackgroundImage(UIColor.yellow.toImage, for: .normal)
                hint.setBackgroundImage(UIColor.darkGray.toImage, for: .selected)
                hint.isSelected = switchs?.hints[index] == 1 ? true : false
            }
        }
    }
    @IBOutlet weak var topLevelView: UIStackView!
    var switchs: LightSwitch?
}
