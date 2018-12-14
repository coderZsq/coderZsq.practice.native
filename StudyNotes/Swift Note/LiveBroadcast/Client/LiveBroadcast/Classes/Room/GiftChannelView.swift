//
//  GiftChannelView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

enum GiftChannelViewState {
    case idle
    case animating
    case willEnd
    case endAnimating
}

class GiftChannelView: UIView, NibLoadable {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var giftDescLabel: UILabel!
    @IBOutlet weak var giftImageView: UIImageView!
    @IBOutlet weak var digitLabel: GiftDigitLabel!
    
    fileprivate var cacheNumber = 0
    fileprivate var currentNumber = 0
    var state = GiftChannelViewState.idle
    
    var giftChannelModel: GiftChannelModel? {
        didSet {
            guard let giftChannelModel = giftChannelModel  else {
                return
            }
            iconImageView.image = UIImage(named: giftChannelModel.senderURL)
            senderLabel.text = giftChannelModel.senderName
            giftDescLabel.text = "送出礼物：【\(giftChannelModel.giftName)】"
            giftImageView.image = UIImage(named: giftChannelModel.giftURL)
            state = .animating
            performAnimation()
        }
    }

}

extension GiftChannelView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layer.cornerRadius = frame.height * 0.5
        iconImageView.layer.cornerRadius = frame.height * 0.5
        bgView.layer.masksToBounds = true
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 1
        iconImageView.layer.borderColor = UIColor.green.cgColor
    }
    
}

extension GiftChannelView {
    
    func addOnceToCache() {
        if state == .willEnd {
            performDigitAnimation()
            NSObject.cancelPreviousPerformRequests(withTarget: self)
        } else {
            cacheNumber += 1
        }
    }
    
}

extension GiftChannelView {
    
    fileprivate func performAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 1.0
            self.frame.origin.x = 0
        }) { (isFinished) in
            self.performDigitAnimation()
        }
    }
    
    fileprivate func performDigitAnimation() {
        currentNumber += 1
        digitLabel.text = "x\(currentNumber)"
        digitLabel.showDigitAnimation {
            if self.cacheNumber > 0 {
                self.cacheNumber -= 1
                self.performDigitAnimation()
            } else {
                self.state = .willEnd
                self.perform(#selector(self.performEndAnimation), with: nil, afterDelay: 3.0)
            }
        }
    }
    
    @objc fileprivate func performEndAnimation() {
        state = .endAnimating
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin.x = UIScreen.main.bounds.width
            self.alpha = 0.0
        }) { (isFinished) in
            self.giftChannelModel = nil
            self.frame.origin.x = -self.frame.width
            self.state = .idle
        }
    }
    
}
