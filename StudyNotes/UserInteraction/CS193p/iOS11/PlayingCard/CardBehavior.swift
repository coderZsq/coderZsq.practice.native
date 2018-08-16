//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by 朱双泉 on 2018/5/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class CardBehavior: UIDynamicBehavior {

    lazy var collisionBahavior: UICollisionBehavior = {
        let bahavior = UICollisionBehavior()
        bahavior.translatesReferenceBoundsIntoBoundary = true
        return bahavior
    }()
    
    lazy var itemBahavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0
        behavior.resistance = 0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        if let referenceBounds = dynamicAnimator?.referenceView?.bounds {
            let center = CGPoint(x: referenceBounds.midX, y: referenceBounds.midY)
            switch (item.center.x, item.center.y) {
            case let (x, y) where x < center.x && y < center.y:
                push.angle = (CGFloat.pi/2).arc4random
            case let (x, y) where x > center.x && y < center.y:
                push.angle = CGFloat.pi-(CGFloat.pi/2).arc4random
            case let (x, y) where x < center.x && y > center.y:
                push.angle = (-CGFloat.pi/2).arc4random
            case let (x, y) where x > center.x && y > center.y:
                push.angle = CGFloat.pi+(CGFloat.pi/2).arc4random
            default:
                push.angle = (CGFloat.pi*2).arc4random
            }
        }
        push.magnitude = CGFloat(1.0) + CGFloat(2.0).arc4random
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    var gravityBehavior: UIGravityBehavior = {
        let behavior = UIGravityBehavior()
        behavior.magnitude = 0
        return behavior
    }()
    
    func addItem(_ item: UIDynamicItem) {
        collisionBahavior.addItem(item)
        itemBahavior.addItem(item)
        gravityBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBahavior.removeItem(item)
        itemBahavior.removeItem(item)
        gravityBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBahavior)
        addChildBehavior(itemBahavior)
        addChildBehavior(gravityBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
}
