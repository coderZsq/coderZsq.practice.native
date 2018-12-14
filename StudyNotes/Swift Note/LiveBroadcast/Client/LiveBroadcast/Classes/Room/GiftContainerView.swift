//
//  GiftContainerView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

private let kChannelCount = 2
private let kChannelViewH : CGFloat = 40
private let kChannelMargin : CGFloat = 10

class GiftContainerView: UIView {

    fileprivate lazy var channelViews = [GiftChannelView]()
    fileprivate lazy var cacheGiftChannelModels = [GiftChannelModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GiftContainerView {
    
    fileprivate func setupUI() {
        let w : CGFloat = frame.width
        let h : CGFloat = kChannelViewH
        let x : CGFloat = 0
        for i in 0..<kChannelCount {
            let y : CGFloat = (h + kChannelMargin) * CGFloat(i)
            let channelView = GiftChannelView.loadFromNib()
            channelView.frame = CGRect(x: x, y: y, width: w, height: h)
            channelView.alpha = 0.0
            addSubview(channelView)
            channelViews.append(channelView)
            channelView.completionCallback = { channelView in
                guard self.cacheGiftChannelModels.count != 0 else {
                    return
                }
                let firstGiftChannelModel = self.cacheGiftChannelModels.first!
                self.cacheGiftChannelModels.removeFirst()
                channelView.giftChannelModel = firstGiftChannelModel
                for i in (0..<self.cacheGiftChannelModels.count).reversed() {
                    let giftChannelModel = self.cacheGiftChannelModels[i]
                    if giftChannelModel.isEqual(firstGiftChannelModel) {
                        channelView.addOnceToCache()
                        self.cacheGiftChannelModels.remove(at: i)
                    }
                }
            }
        }
    }
    
}

extension GiftContainerView {
    
    func showGiftChannelView(_ giftChannelModel: GiftChannelModel) {
        if let channelView = checkUsingChannelView(giftChannelModel) {
            channelView.addOnceToCache()
            return
        }
        if let channelView = checkIdleChanelView() {
            channelView.giftChannelModel = giftChannelModel
            return
        }
        cacheGiftChannelModels.append(giftChannelModel)
    }
    
    private func checkUsingChannelView(_ giftChannelModel: GiftChannelModel) -> GiftChannelView? {
        for channelView in channelViews {
            if giftChannelModel.isEqual(channelView.giftChannelModel) && channelView.state != .endAnimating {
                return channelView
            }
        }
        return nil
    }
    
    private func checkIdleChanelView() -> GiftChannelView? {
        for channelView in channelViews {
            if channelView.state == .idle {
                return channelView
            }
        }
        return nil
    }
}
