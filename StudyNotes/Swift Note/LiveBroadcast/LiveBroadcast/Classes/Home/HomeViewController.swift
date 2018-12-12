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
        
    }
}

extension HomeViewController {
   
    fileprivate func setupUI() {
        setupNavigationBar()
        setupContentView()
    }
    
    private func setupContentView() {
        let homeTypes = loadTypesData()
        let titles = homeTypes.map({ $0.title })
        var childVcs = [AnchorViewController]()
        for type in homeTypes {
            let anchorVc = AnchorViewController()
            anchorVc.homeType = type
            childVcs.append(anchorVc)
        }
        let style = TitleStyle()
        style.isScrollEnable = true
        style.isShowScrollLine = true
        let statusbarH = UIApplication.shared.statusBarFrame.size.height
        let navbarH = navigationController!.navigationBar.frame.size.height
        let tabbarH = tabBarController!.tabBar.frame.size.height
        let pageFrame = CGRect(x: 0, y: statusbarH + navbarH, width: view.bounds.width, height: view.bounds.height - statusbarH - navbarH - tabbarH)
        let pageView = PageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, style: style)
        view.addSubview(pageView)
    }
    
    fileprivate func loadTypesData() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let dataArray = NSArray(contentsOfFile: path) as! [[String : Any]]
        var tempArray = [HomeType]()
        for dict in dataArray {
            tempArray.append(HomeType(dict: dict))
        }
        return tempArray
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
        
        navigationController?.navigationBar.barTintColor = UIColor.black
    }
}

extension HomeViewController {
    @objc fileprivate func collectItemClick() {
        print("弹出收藏控制器")
    }
}
