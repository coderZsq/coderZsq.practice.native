//
//  ChatToolsView.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/12.
//  Copyright © 2018 Castie!. All rights reserved.
//


import UIKit

protocol ChatToolsViewDelegate : class {
    func chatToolsView(toolView : ChatToolsView, message : String)
}

class ChatToolsView: UIView, NibLoadable {
    
    weak var delegate : ChatToolsViewDelegate?
    
    fileprivate lazy var emoticonBtn : UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    fileprivate lazy var emoticonView = EmoticonView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 250))
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendMsgBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    @IBAction func textFieldDidEdit(_ sender: UITextField) {
        sendMsgBtn.isEnabled = sender.text!.count != 0
    }
    
    @IBAction func sendBtnClick(_ sender: UIButton) {
        let message = inputTextField.text!
        inputTextField.text = ""
        sender.isEnabled = false
        delegate?.chatToolsView(toolView: self, message: message)
    }
}


extension ChatToolsView {
    fileprivate func setupUI() {
        emoticonBtn.setImage(UIImage(named: "chat_btn_emoji"), for: .normal)
        emoticonBtn.setImage(UIImage(named: "chat_btn_keyboard"), for: .selected)
        emoticonBtn.addTarget(self, action: #selector(emoticonBtnClick(_:)), for: .touchUpInside)
        inputTextField.rightView = emoticonBtn
        inputTextField.rightViewMode = .always
        inputTextField.allowsEditingTextAttributes = true
        emoticonView.emotionClickCallback = { [weak self] emoticon in
            if emoticon.emoticonName == "delete-n" {
                self?.inputTextField.deleteBackward()
                return
            }
            guard let range = self?.inputTextField.selectedTextRange else { return }
            self?.inputTextField.replace(range, withText: emoticon.emoticonName)
        }
    }
}

extension ChatToolsView {
    @objc fileprivate func emoticonBtnClick(_ btn : UIButton) {
        btn.isSelected = !btn.isSelected
        let range = inputTextField.selectedTextRange
        inputTextField.resignFirstResponder()
        inputTextField.inputView = inputTextField.inputView == nil ? emoticonView : nil
        inputTextField.becomeFirstResponder()
        inputTextField.selectedTextRange = range
    }
}
