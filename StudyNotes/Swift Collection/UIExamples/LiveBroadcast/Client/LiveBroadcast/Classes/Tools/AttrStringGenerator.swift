//
//  AttrStringGenerator.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import Kingfisher

class AttrStringGenerator {

}

extension AttrStringGenerator {
    
    class func generateJoinLeaveRoom(_ username: String, isJoin: Bool) -> NSAttributedString {
        let roomString = "\(username) " + (isJoin ? "进入房间" : "离开房间")
        let roomMAttr = NSMutableAttributedString(string: roomString)
        roomMAttr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], range: NSRange(location: 0, length: username.count))
        return roomMAttr
    }
    
    class func generateTextMessage(_ username: String, message: String) -> NSAttributedString {
        let textMessage = "\(username): \(message)"
        let textMessageMAttr = NSMutableAttributedString(string: textMessage)
        textMessageMAttr.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], range: NSRange(location: 0, length: username.count))
        let pattern = "\\[.*?\\]"
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return textMessageMAttr
        }
        let results = regex.matches(in: textMessage, options: [], range: NSRange(location: 0, length: textMessage.count))
        for i in (0..<results.count).reversed() {
            let result = results[i]
            let emoticonName = (textMessage as NSString).substring(with: result.range)
            guard let image = UIImage(named: emoticonName) else {
                continue
            }
            let attachment = NSTextAttachment()
            attachment.image = image
            let font = UIFont.systemFont(ofSize: 15)
            attachment.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
            let imageAttrStr = NSAttributedString(attachment: attachment)
            textMessageMAttr.replaceCharacters(in: result.range, with: imageAttrStr)
        }
        return textMessageMAttr
    }
    
    class func generateGiftMessage(_ username: String, giftname: String, giftURL: String) -> NSAttributedString {
        let sendGiftMsg = "\(username) 赠送了 \(giftname) "
        let sendGiftMAttrMsg = NSMutableAttributedString(string: sendGiftMsg)
        sendGiftMAttrMsg.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], range: NSRange(location: 0, length: username.count))
        let range = (sendGiftMsg as NSString).range(of: giftname)
        sendGiftMAttrMsg.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: range)
        //        guard let giftURL = URL(string: giftMsg.gitUrl) else {
        //            return
        //        }
        //        KingfisherManager.shared.downloader.downloadImage(with: giftURL) { (image, error, _, _) in
        //
        //        }
        guard let image = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: giftURL) else {
            return sendGiftMAttrMsg
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        let font = UIFont.systemFont(ofSize: 15)
        attachment.bounds = CGRect(x: 0, y: -3, width: font.lineHeight, height: font.lineHeight)
        let imageAttrStr = NSAttributedString(attachment: attachment)
        sendGiftMAttrMsg.append(imageAttrStr)
        return sendGiftMAttrMsg
    }
    
}
