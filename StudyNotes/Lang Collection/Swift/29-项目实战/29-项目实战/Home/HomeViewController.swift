//
//  HomeViewController.swift
//  29-项目实战
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

class HomeViewController: UIViewController {
    
    lazy var tableView = UITableView()
    lazy var items = [Item]()
    static let ItemCellId = "item"
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Self.ItemCellId)
        view.addSubview(tableView)
        
        let header = MJRefreshNormalHeader(refreshingBlock: self.loadNewData)
        header?.beginRefreshing()
        tableView.mj_header = header
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: self.loadMoreData)
    }
    
    func loadNewData() {
        request(API.imgrank,  parameters: ["page": 1]).responseJSON {
            [weak self] response in
            guard
                let dict = response.result.value,
                let jsons = JSON(dict)["items"].arrayObject else { return }
            let models = modelArray(from: jsons, Item.self)
            
            self?.items.removeAll()
            self?.items.append(contentsOf: models)
            
            self?.tableView.reloadData()
            self?.tableView.mj_header.endRefreshing()
            
            self?.page = 1
        }
    }
    
    func loadMoreData() {
        request(API.imgrank,  parameters: ["page": page + 1]).responseJSON {
            [weak self] response in
            guard
                let dict = response.result.value,
                let jsons = JSON(dict)["items"].arrayObject else { return }
            let models = modelArray(from: jsons, Item.self)
            
            self?.items.append(contentsOf: models)
            
            self?.tableView.reloadData()
            self?.tableView.mj_footer.endRefreshing()
            
            self?.page += 1
        }
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer.isHidden = items.count == 0
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellId, for: indexPath)
        var tmp = tableView.dequeueReusableCell(withIdentifier: Self.ItemCellId)
        if tmp == nil {
            tmp = UITableViewCell(style: .subtitle, reuseIdentifier: Self.ItemCellId)
        }
        let cell = tmp!
        
        let item = items[indexPath.row]
        cell.textLabel?.text = item.user.name
        cell.imageView?.kf.setImage(with: URL(string: item.user.thumb),
                                    options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
