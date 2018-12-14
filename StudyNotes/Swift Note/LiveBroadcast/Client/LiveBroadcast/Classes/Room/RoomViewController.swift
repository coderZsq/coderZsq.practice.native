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
private let kChatContentViewHeight: CGFloat = 200

class RoomViewController: UIViewController {
    
    
    @IBOutlet weak var testLabel: GiftDigitLabel!
    fileprivate lazy var giftContainerView = GiftContainerView()
    
    @IBOutlet weak var bgImageView: UIImageView!
    fileprivate lazy var chatToolsView = ChatToolsView.loadFromNib()
    fileprivate lazy var giftListView = GiftListView.loadFromNib()
    fileprivate lazy var chatContentView = ChatContentView.loadFromNib()
    fileprivate lazy var socket = Socket(addr: "0.0.0.0", port: 6666)
    fileprivate var heartBeatTimer: Timer?
    
    deinit {
        heartBeatTimer?.invalidate()
        heartBeatTimer = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        if socket.connectServer() {
            addHeartBeatTimer()
            socket.sendJoinRoom()
            socket.startReadMessage()
            socket.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        socket.sendLeaveRoom()
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
        chatContentView.frame = CGRect(x: 0, y: view.bounds.height - kChatToolsViewHeight - kChatContentViewHeight, width: view.bounds.width, height: kChatContentViewHeight)
        chatContentView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        view.addSubview(chatContentView)
        chatToolsView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kChatToolsViewHeight)
        chatToolsView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        chatToolsView.delegate = self
        view.addSubview(chatToolsView)
        giftListView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftListViewHeight)
        giftListView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        giftListView.delegate = self
        view.addSubview(giftListView)
    }
    
    fileprivate func addHeartBeatTimer() {
        heartBeatTimer = Timer(fireAt: Date(), interval: 9, target: self, selector: #selector(sendHeartBeat), userInfo: nil, repeats: true)
        RunLoop.main.add(heartBeatTimer!, forMode: .common)
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
            let contentEndY = inputViewY == (kScreenH - kChatToolsViewHeight) ? (kScreenH - kChatContentViewHeight - kChatToolsViewHeight) : endY - kChatContentViewHeight
            self.chatContentView.frame.origin.y = contentEndY
        }
    }
    
}

extension RoomViewController: ChatToolsViewDelegate {
    
    func chatToolsView(toolView: ChatToolsView, message: String) {
        socket.sendTextMsg(message: message)
    }

}

extension RoomViewController: GiftListViewDelegate {
    
    func giftListView(giftView: GiftListView, giftModel: GiftModel) {
        socket.sendGiftMsg(giftName: giftModel.subject, giftURL: giftModel.img2, giftCount: 1)
    }
    
}

extension RoomViewController {
    
    @objc fileprivate func sendHeartBeat() {
        socket.sendHeartBeat()
    }
    
}

extension RoomViewController: SocketDelegate {
    
    func socket(_ socket: Socket, joinRoom user: UserInfo) {
        chatContentView.insertMessage(AttrStringGenerator.generateJoinLeaveRoom(user.name, isJoin: true))
    }
    
    func socket(_ socket: Socket, leaveRoom user: UserInfo) {
        chatContentView.insertMessage(AttrStringGenerator.generateJoinLeaveRoom(user.name, isJoin: false))
    }
    
    func socket(_ socket: Socket, textMsg: TextMessage) {
        chatContentView.insertMessage(AttrStringGenerator.generateTextMessage(textMsg.user.name, message: textMsg.text))
    }
    
    func socket(_ socket: Socket, giftMsg: GiftMessage) {
        chatContentView.insertMessage(AttrStringGenerator.generateGiftMessage(giftMsg.user.name, giftname: giftMsg.giftname, giftURL: giftMsg.gitUrl))
    }
    
}

extension RoomViewController {
    
    @IBAction func a(_ sender: Any) {
        let gift1 = GiftChannelModel(senderName: "SSS", senderURL: "DDD", giftName: "233", giftURL: "DDD")
        giftContainerView.showGiftChannelView(gift1)
    }
    
    
    @IBAction func b(_ sender: Any) {
        let gift1 = GiftChannelModel(senderName: "SSS1", senderURL: "DDD", giftName: "233", giftURL: "DDD")
        giftContainerView.showGiftChannelView(gift1)
    }
    
    
    @IBAction func c(_ sender: Any) {
        let gift1 = GiftChannelModel(senderName: "SSS2", senderURL: "DDD", giftName: "233", giftURL: "DDD")
        giftContainerView.showGiftChannelView(gift1)
    }
    
}
