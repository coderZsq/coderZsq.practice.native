//
//  HomeAnimation.swift
//  PhotoBrowser
//
//  Created by 朱双泉 on 2018/10/30.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

protocol HomeAnimationPresentDelegate: class {
    func presentAnimationView() -> UIView
    func presentAnimationFromFrame() -> CGRect
    func presentAnimationToFrame() -> CGRect
}

protocol HomeAnimationDismissDelegate: class {
    func dismissAnimationView() -> UIView
    func dismissAnimationFromFrame() -> CGRect
    func dismissAnimationToFrame() -> CGRect
}

class HomeAnimation: NSObject, UIViewControllerTransitioningDelegate {

    weak var presentDelegate: HomeAnimationPresentDelegate?
    weak var dismissDelegate: HomeAnimationDismissDelegate?
    
    var isPresent = true
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
}

extension HomeAnimation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            presentAnimation(transitionContext: transitionContext)
        } else {
            dismissAnimation(transitionContext: transitionContext)
        }
    }
    
    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let dismissDelegate = dismissDelegate else {
            return
        }
        
        let containerView = transitionContext.containerView
        let animationView = dismissDelegate.dismissAnimationView()
        let fromFrame = dismissDelegate.dismissAnimationFromFrame()
        let toFrame = dismissDelegate.dismissAnimationToFrame()
        
        containerView.addSubview(animationView)
        animationView.frame = fromFrame
        
        let fromView = transitionContext.view(forKey: .from)

        UIView.animate(withDuration: 1, animations: {
            animationView.frame = toFrame
            fromView?.alpha = 0
        }) { (complete) in
            animationView.removeFromSuperview()
            fromView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
    
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let presentDelegate = presentDelegate else {
            return
        }
        
        let containerView = transitionContext.containerView
        let animationView = presentDelegate.presentAnimationView()
        let fromFrame = presentDelegate.presentAnimationFromFrame()
        let toFrame = presentDelegate.presentAnimationToFrame()
        
        containerView.addSubview(animationView)
        animationView.frame = fromFrame
        
        let detailView = transitionContext.view(forKey: .to)
        detailView?.frame = kScreenBounds
        containerView.addSubview(detailView!)
        detailView?.alpha = 0
        
        UIView.animate(withDuration: 1, animations: {
            animationView.frame = toFrame
            detailView?.alpha = 1
        }) { (complete) in
            animationView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
