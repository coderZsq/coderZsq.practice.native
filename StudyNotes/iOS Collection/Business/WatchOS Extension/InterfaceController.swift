//
//  InterfaceController.swift
//  WatchOS Extension
//
//  Created by 朱双泉 on 2018/12/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var label: WKInterfaceLabel!
    @IBOutlet weak var image: WKInterfaceImage!
    @IBOutlet weak var animteImage: WKInterfaceImage!
    @IBOutlet weak var button: WKInterfaceButton!
    @IBOutlet weak var table: WKInterfaceTable!
    
    @IBAction func buttonClickAction() {
//        button.setEnabled(false)
//        pushController(withName: <#T##String#>, context: <#T##Any?#>)
        presentController(withName: "vc1", context: nil)
//        presentController(withNames: ["vc1", "vc2"], contexts: nil)
    }
    
    @IBAction func insertRow() {
        table.insertRows(at: IndexSet(integer: 0), withRowType: "row1");
    }
    
    @IBAction func removeRow() {
        table.removeRows(at: IndexSet(integer: 0))
    }
    
    @IBAction func scrollToBottom() {
        table.scrollToRow(at: table.numberOfRows - 1)
    }
    
    override init() {
        super.init()
        print("init")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        print("awake")
        label.setText("Castie!")
        label.setTextColor(.red)
        label.setAttributedText(NSAttributedString(string: "Castie!", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : UIColor.orange
            ]))
        image.setImage(UIImage(named: "ad_00"))
        image.setImageNamed("ad_00")
        image.setImageData(UIImage(named: "ad_00")?.pngData())
        animteImage.setImageNamed("spinner")
        animteImage.startAnimatingWithImages(in: NSMakeRange(0, 42), duration: 5, repeatCount: 0)
        button.setAttributedTitle(NSAttributedString(string: "Castie! Button", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12.0),
            NSAttributedString.Key.foregroundColor : UIColor.orange
            ]))
//        let bgColor = UIColor(patternImage: UIImage(named: "ad_00")!)
        button.setBackgroundColor(.green)
        button.setBackgroundImage(UIImage(named: "ad_01"))
        button.setBackgroundImageNamed("ad_00")
        button.setBackgroundImageData(UIImage(named: "ad_01")?.pngData())
//        table.setRowTypes(["row0", "row0", "row0", "row1"])
//        table.setNumberOfRows(5, withRowType: "row1")
        table.setRowTypes(["row0", "row1", "row2"])
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        print("willActivate")
        let row = table.rowController(at: 2) as! TableRow
        row.text = "Castiel Row"
        row.imageName = "ad_03"
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("didDeactivate")
    }

    deinit {
        print("deinit")
    }
}
