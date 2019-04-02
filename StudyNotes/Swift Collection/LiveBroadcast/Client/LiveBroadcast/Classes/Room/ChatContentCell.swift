//
//  ChatContentCell.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

class ChatContentCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = .white
        selectionStyle = .none
    }

}
