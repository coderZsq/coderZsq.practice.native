//
//  RoomViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

private let kChatToolsViewHeight: CGFloat = 44
private let kGiftListViewHeight: CGFloat = 320
private let kEmoticonCell = "kEmoticonCell"

class RoomViewController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    fileprivate lazy var chatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var giftListView = GiftListView.loadFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


extension RoomViewController {
    
    fileprivate func setupUI() {
        setupBlurView()
        setupBottomView()
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupBottomView() {
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftListViewHeight)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        giftListView.delegate = self
        view.addSubview(giftListView)
    }
}

extension RoomViewController: Emitterable {
    
    @IBAction func exitBtnClick() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatToolsView.inputTextField.resignFirstResponder()
        UIView.animate(withDuration: 0.25) {
            self.giftListView.frame.origin.y = kScreenH
        }
    }
    
    @IBAction func bottomMenuClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            chatToolsView.inputTextField.becomeFirstResponder()
        case 1:
            print("点击了分享")
        case 2:
            UIView.animate(withDuration: 0.25) {
                self.giftListView.frame.origin.y = kScreenH - kGiftListViewHeight
            }
        case 3:
            print("点击了更多")
        case 4:
            sender.isSelected = !sender.isSelected
            let point = CGPoint(x: sender.center.x, y: view.bounds.height - sender.bounds.height * 0.5)
            sender.isSelected ? startEmittering(point) : stopEmittering()
        default:
            fatalError("未处理按钮")
        }
    }
}

extension RoomViewController {
    
    @objc fileprivate func keyboardWillChangeFrame(_ note: Notification) {
        let duration = note.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let endFrame = (note.userInfo![UIResponder.keyboardFrameEndUserInfoKey]) as! CGRect
        let inputViewY = endFrame.origin.y - kChatToolsViewHeight
        UIView.animate(withDuration: duration) {
            UIView.setAnimationCurve(UIView.AnimationCurve(rawValue: 7)!)
            let endY = inputViewY == (self.view.bounds.height - kChatToolsViewHeight) ? self.view.bounds.height : inputViewY
            self.chatToolsView.frame.origin.y = endY
        }
    }
    
}

extension RoomViewController: ChatToolsViewDelegate {
    
    func chatToolsView(toolView: ChatToolsView, message: String) {
        print(message)
    }

}

extension RoomViewController: GiftListViewDelegate {
    
    func giftListView(giftView: GiftListView, giftModel: GiftModel) {
        print(giftModel.subject)
    }
    
}
