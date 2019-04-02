//
//  EmojiArtView.swift
//  EmojiArt
//
//  Created by 朱双泉 on 2018/5/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol EmojiArtViewDelegate: class {
    func emojiArtViewDidChange(_ sneder: EmojiArtView)
}

extension Notification.Name {
    static let EmojiArtViewDidChange = Notification.Name("EmojiArtViewDidChange")
}

class EmojiArtView: UIView, UIDropInteractionDelegate {

    weak var delegate: EmojiArtViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addInteraction(UIDropInteraction(delegate: self))
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        return session.canLoadObjects(ofClass: NSAttributedString.self)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
        return UIDropProposal(operation: .copy)
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        session.loadObjects(ofClass: NSAttributedString.self) { providers in
            let dropPoint = session.location(in: self)
            for attributedString in providers as? [NSAttributedString] ?? [] {
                self.addLabel(with: attributedString, centeredAt: dropPoint)
                self.delegate?.emojiArtViewDidChange(self)
                NotificationCenter.default.post(name: .EmojiArtViewDidChange, object: self)
            }
        }
    }
    
    private var labelObservations = [UIView : NSKeyValueObservation]()
    
    func addLabel(with attributedString: NSAttributedString, centeredAt point: CGPoint) {
        let label = UILabel()
        label.backgroundColor = .clear
        label.attributedText = attributedString
        label.sizeToFit()
        label.center = point
        addEmojiArtGestureRecognizers(to: label)
        addSubview(label)
        labelObservations[label] = label.observe(\.center) { (label, change) in
            self.delegate?.emojiArtViewDidChange(self)
            NotificationCenter.default.post(name: .EmojiArtViewDidChange, object: self)
        }
    }
   
    override func willRemoveSubview(_ subview: UIView) {
        super.willRemoveSubview(subview)
        if labelObservations[subview] != nil {
            labelObservations[subview] = nil
        }
    }
    
    var backgroundImage: UIImage? { didSet { setNeedsDisplay() }}
    
    override func draw(_ rect: CGRect) {
        backgroundImage?.draw(in: bounds)
    }
}
