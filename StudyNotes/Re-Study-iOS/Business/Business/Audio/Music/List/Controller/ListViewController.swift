//
//  ListViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/15.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var musicModels = [MusicModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInit()
        musicModels = DataTool.getMusicListData()
        MusicOperationTool.shared.musicModels = musicModels
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        navigationController?.popViewController(animated: true)
    }
}

extension ListViewController {
    
    func setupInit() {
        navigationController?.isNavigationBarHidden = true
        setTableView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setTableView() {
        tableView.rowHeight = 60
        let image = UIImage(named: "QQListBack.jpg")
        let imageView = UIImageView(image: image)
        tableView.backgroundView = imageView
        tableView.separatorStyle = .none
    }
}

extension ListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MusicListCell.cellWith(tableView: tableView)
        cell?.musicModel = musicModels[indexPath.row]
        cell?.animation(type: .scale)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let musicModel = musicModels[indexPath.row]
        MusicOperationTool.shared.playMusic(musicModel: musicModel)
        if let vc = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateInitialViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
