//
//  EventCell.swift
//  Our Planet
//
//  Created by 双泉 朱 on 17/4/21.
//  Copyright © 2017年 Doubles_Z. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configure(event: EOEvent) {
        
        title.text = event.title
        details.text = event.description
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        if let when = event.closeDate {
            date.text = formatter.string(for: when)
        } else {
            date.text = ""
        }
    }
}
