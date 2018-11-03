//
//  ADViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import iAd

class ADViewController: UIViewController {
    
    lazy var adView: ADBannerView = {
        let adView = ADBannerView()
        adView.delegate = self
        return adView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(adView)
    }
}

extension ADViewController: ADBannerViewDelegate {
    
    func bannerViewDidLoadAd(_ banner: ADBannerView) {
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
}
