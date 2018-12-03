//
//  os2InterfaceController.swift
//  WatchOS Extension
//
//  Created by 朱双泉 on 2018/12/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import WatchKit
import Foundation

private var index = 0

extension WKPickerItem {
    convenience init(title: String?, caption: String?, accessoryImage: WKImage?, contentImage: WKImage?) {
        self.init()
        self.title = title
        self.caption = caption
        self.accessoryImage = accessoryImage
        self.contentImage = contentImage
    }
}

class os2InterfaceController: WKInterfaceController {

    @IBOutlet weak var picker: WKInterfacePicker!
    @IBAction func pickerAction(_ value: Int) {
        print(value)
    }
    
    @IBOutlet weak var button: WKInterfaceButton!
    @IBAction func buttonClick() {
        animate(withDuration: 2.0) {
            self.button.setHorizontalAlignment(.right)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.animate(withDuration: 2.0, animations: {
                    self.button.setHorizontalAlignment(.left)
                })
            })
        }
    }
    
    lazy var actions: [WKAlertAction] = {
        var actions = [WKAlertAction]()
        let action0 = WKAlertAction(title: "action0", style: .default, handler: {
            
        })
        let action1 = WKAlertAction(title: "action1", style: .cancel, handler: {
            
        })
        let action2 = WKAlertAction(title: "action2", style: .destructive, handler: {
            
        })
        actions.append(action0)
        actions.append(action1)
        actions.append(action2)
        return actions
    }()
    
    @IBAction func allPresentEvents() {
//        presentAlert(withTitle: "title", message: "message", preferredStyle: .alert, actions: actions)
//        presentAlert(withTitle: "title", message: "message", preferredStyle: .actionSheet, actions: actions)
        presentAlert(withTitle: "title", message: "message", preferredStyle: .sideBySideButtonsAlert, actions: [actions.first!, actions.last!])

    }
    
    @IBAction func otherPresentEvents() {
        audioRecorder()
//        mediaPlayer()
//        textInput()
//        customTextInput()
    }
    
    func customTextInput() {
        presentTextInputControllerWithSuggestions(forLanguage: { (str) -> [Any]? in
            print(str)
            return []
        }, allowedInputMode: .allowAnimatedEmoji) { (res) in
            print(res ?? "")
        }
    }
    
    func textInput() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: .allowAnimatedEmoji) { (res) in
            print(res ?? "")
        }
    }
    
    func mediaPlayer() {
        let path = NSHomeDirectory() + "/os2.mp4"
        let url = URL(fileURLWithPath: path)
        presentMediaPlayerController(with: url, options: nil) { (isC, timer, error) in
            print(isC, timer, error ?? "")
        }
    }
    
    func audioRecorder() {
        let path = NSHomeDirectory() + "/os2.mp4"
        let url = URL(fileURLWithPath: path)
        presentAudioRecorderController(withOutputURL: url, preset: .highQualityAudio, options: nil) { (isC, error) in
            print(isC, error ?? "")
        }
    }
    
    lazy var items:[WKPickerItem] = {
        let ima: WKImage = WKImage(image: UIImage(named: "spinner1")!)
        let cIma = WKImage(image: UIImage(named: "ad_00")!)
        let item0 = WKPickerItem(title: "item0", caption: "cap0", accessoryImage: ima, contentImage: cIma)
        let item1 = WKPickerItem(title: "t1", caption: "cap1", accessoryImage: WKImage(image: UIImage(named: "spinner1")!), contentImage: WKImage(image: UIImage(named: "ad_01")!))
        let item2 = WKPickerItem(title: "t2", caption: "cap2", accessoryImage: WKImage(image: UIImage(named: "spinner1")!), contentImage: WKImage(image: UIImage(named: "ad_02")!))
        return [item0, item1, item2]
    }()
    
    override func pickerDidFocus(_ picker: WKInterfacePicker) {
        print("pickerDidFocus")
    }
    
    override func pickerDidResignFocus(_ picker: WKInterfacePicker) {
        print("pickerDidResignFocus")
    }
    
    override func pickerDidSettle(_ picker: WKInterfacePicker) {
        print("pickerDidSettle")
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        guard index == 0 else {
            return;
        }
        WKInterfaceController.reloadRootControllers(withNames: ["os2","vc1", "vc2", "vc3", "vc4"], contexts: nil)
        index += 1

        picker.setItems(items)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

