//
//  HomeViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let titles = ["游戏", "娱乐", "趣玩", "美女", "颜值"]
        let style = TitleStyle()
        style.isScrollEnable = false
        style.isShowScrollLine = true
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        let y = UIApplication.shared.statusBarFrame.size.height + navigationController!.navigationBar.frame.size.height
        let pageFrame = CGRect(x: 0, y: y + 10, width: view.bounds.width, height: view.bounds.height)
        let pageView = PageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style: style)
        view.addSubview(pageView)
    }
}

extension HomeViewController {
   
    fileprivate func setupUI() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let logoImage = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImage, style: .plain, target: nil, action: nil)
        
        let collectImage = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImage, style: .plain, target: self, action: #selector(collectItemClick))
        
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.placeholder = "主播昵称/房间号/链接"
        navigationItem.titleView = searchBar
        searchBar.searchBarStyle = .minimal
        
        let searchFiled = searchBar.value(forKey: "_searchField") as? UITextField
        searchFiled?.textColor = UIColor.white
    }
}

extension HomeViewController {
    @objc fileprivate func collectItemClick() {
        print("弹出收藏控制器")
    }
}
