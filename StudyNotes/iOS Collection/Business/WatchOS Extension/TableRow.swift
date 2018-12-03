//
//  TableRow.swift
//  WatchOS Extension
//
//  Created by 朱双泉 on 2018/12/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import WatchKit

class TableRow: NSObject {

    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var label: WKInterfaceLabel!
    
    var imageName: String? {
        didSet{
            image.setImage(UIImage(named: imageName!))
        }
    }
    
    var text: String? {
        didSet{
            label.setText(text)
        }
    }
}
