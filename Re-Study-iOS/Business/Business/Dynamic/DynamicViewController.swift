//
//  DynamicViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController {

    @IBOutlet weak var ipad_pro_12_9: UIImageView!
    @IBOutlet weak var ipad_pro_11_0: UIImageView!
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        gravity()
        collision()
        if let point = touches.first?.location(in: view) {
            snap(point: point)
        }
        push()
    }
    
    func push() {
        let behavior = UIPushBehavior(items: [ipad_pro_12_9], mode: .instantaneous)
        behavior.pushDirection = CGVector(dx: 0, dy: -10)
        animator.addBehavior(behavior)
    }
    
    func snap(point: CGPoint) {
        animator.removeAllBehaviors()
        let behavior = UISnapBehavior(item: ipad_pro_11_0, snapTo: point)
        animator.addBehavior(behavior)
    }
    
    func collision() {
        let behavior = UICollisionBehavior(items: [ipad_pro_12_9, ipad_pro_11_0])
        behavior.translatesReferenceBoundsIntoBoundary = true
        behavior.collisionMode = .everything
        behavior.addBoundary(withIdentifier: "line" as NSCopying, from: CGPoint(x: 0, y: 500), to: CGPoint(x: view.frame.size.width, y: 400))
        behavior.collisionDelegate = self
        animator.addBehavior(behavior)
    }
    
    func gravity() {
        let behavior = UIGravityBehavior(items: [ipad_pro_12_9])
        behavior.gravityDirection = CGVector(dx: 10, dy: 10)
        behavior.angle = 0
        behavior.magnitude = 100
        animator.addBehavior(behavior)
    }
}

extension DynamicViewController: UICollisionBehaviorDelegate {
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print("开始元素碰撞元素")
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        print("开始元素碰撞边界")
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        print("结束元素碰撞边界")
    }
}
