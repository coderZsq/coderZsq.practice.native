//
//  MusicListCell.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

enum AnimationType: Int {
    case rotate
    case scale
}

class MusicListCell: UITableViewCell {

    var musicModel: MusicModel? {
        didSet {
            if let named = musicModel?.icon {
                iconImageView.image = UIImage(named: named)
            }
            singerNameLabel.text = musicModel?.singer
            songNameLabel.text = musicModel?.name
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var singerNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView?.layer.cornerRadius = (iconImageView?.width ?? 0.0) / 2.0
        iconImageView?.layer.masksToBounds = true
    }
    
    class func cellWith(tableView: UITableView) -> MusicListCell? {
        var cell = tableView.dequeueReusableCell(withIdentifier: "musicList") as? MusicListCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MusicListCell", owner: nil, options: nil)?.last as? MusicListCell
        }
        return cell
    }

    func animation(type: AnimationType) {
        switch type {
        case .rotate:
            self.layer.removeAnimation(forKey: "rotation")
            let animation = CAKeyframeAnimation(keyPath: "transform.rotation.x")
            animation.values = [-1/4 * Double.pi, 0, 1/4 * Double.pi, 0]
            animation.duration = 0.5
            animation.repeatCount = 2
            self.layer.add(animation, forKey: "rotation")
        case .scale:
            self.layer.removeAnimation(forKey: "scale")
            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.5
            scaleAnimation.toValue = 1
            scaleAnimation.duration = 1
            scaleAnimation.repeatCount = 1
            self.layer.add(scaleAnimation, forKey: "scale")
        }
    }    
}
