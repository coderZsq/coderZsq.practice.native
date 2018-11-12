//
//  iPadHomeViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/12.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class iPadHomeViewController: UIViewController {

    lazy var dock: iPadDockView = {
        let dock = iPadDockView()
        dock.delegate = self
        view.addSubview(dock)
        return dock
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(sender:)))
        contentView.addGestureRecognizer(panGesture)
        view.insertSubview(contentView, aboveSubview: dock)
        return contentView
    }()
    
    @objc
    func pan(sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            print("计算手指点的位置, 移动内容视图")
            let point = sender.translation(in: contentView)
            contentView.left = dock.width + point.x * 0.4
        } else if sender.state == .ended {
            print("恢复内容视图的位置")
            UIView.animate(withDuration: 0.1) {
                self.contentView.left = self.dock.width
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        view.backgroundColor = UIColor(red: 55 / 255.0, green: 55 / 255.0, blue: 55 / 255.0, alpha: 1)
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChangeNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        for i in 0..<6 {
            addChild(UIViewController(), title: "coderZsq - " + "\(i)")
        }
        addChild(iPadAllViewController(), title: "Castie!")
        dockHeadIconDidClick()
    }
    
    func addChild(_ childController: UIViewController, title: String) {
        childController.title = title
        childController.view.backgroundColor = UIColor.darkGray
        let nav = UINavigationController(rootViewController: childController)
        nav.view.layer.cornerRadius = 10
        nav.view.layer.masksToBounds = true
        addChild(nav)
    }
    
    @objc
    func orientationDidChangeNotification() {
        print("orientationDidChangeNotification")
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("viewWillTransition")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
        dock.left = 0
        dock.top = 0
        dock.width = kDockWidth
        dock.height = view.height
        contentView.left = dock.width
        contentView.top = 20
        contentView.width = view.width - dock.width - 20
        contentView.height = view.height - 40
    }
}

extension iPadHomeViewController: iPadDockViewDelegate {
    
    func dockHeadIconDidClick() {
        print("dockHeadIconDidClick")
        let subView = contentView.subviews.first
        subView?.removeFromSuperview()
        if let vc = children.last {
            vc.view.frame = contentView.bounds
            contentView.addSubview(vc.view)
        }
    }
    
    func dockDidSelect(type: iPadTabbarType) {
        print(type)
        if type == .mood {
            let vc = iPadMoodViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .formSheet
            nav.modalTransitionStyle = .crossDissolve
            present(nav, animated: true, completion: nil)
        }
    }
    
    func dockDidSelect(toIndex: Int) {
        print(toIndex)
        let subView = contentView.subviews.first
        subView?.removeFromSuperview()
        let vc = children[toIndex]
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
    }
}
