//
//  BluetoothViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/12/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import MultipeerConnectivity

let serviceType = "castiel"

class BluetoothViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var assistant: MCAdvertiserAssistant = {
        let assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: ["advinfo" : "castiel"], session: session)
        return assistant
    }()
    
    lazy var session: MCSession = {
        let displayName = UIDevice.current.name
        let peer = MCPeerID(displayName: displayName)
        let session = MCSession(peer: peer)
        session.delegate = self
        return session
    }()
    
    lazy var browser: MCBrowserViewController = {
        let browser = MCBrowserViewController(serviceType: serviceType, session: session)
        browser.delegate = self
        return browser
    }()
    
    @IBAction func mcButtonClick(_ sender: UIButton) {
        present(browser, animated: true, completion: nil)
    }
    
    @IBAction func changeAdv(_ sender: UISwitch) {
        sender.isOn ? assistant.start() : assistant.stop()
    }
    
    var msgs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bluetooth"
        assistant.start()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: OperationQueue.main) { (note) in
            if let beginFrame = note.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect, let endFrame = note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                let changeY = endFrame.minY - beginFrame.minY
                self.view.frame = CGRect(origin: CGPoint(x: 0, y: changeY), size: self.view.bounds.size)
            }
        }
    }
}

extension BluetoothViewController: MCBrowserViewControllerDelegate {
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        print(#function, #line)
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        print(#function, #line)
        browserViewController.dismiss(animated: true, completion: nil)
    }
    
//    func browserViewController(_ browserViewController: MCBrowserViewController, shouldPresentNearbyPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) -> Bool {
//        return true
//    }
}

extension BluetoothViewController: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print(session, peerID, state)
        switch state {
        case .notConnected:
            print("notConnected")
        case .connecting:
            print("connecting")
        case .connected:
            print("connected")
            browser.dismiss(animated: true, completion: nil)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print(data, peerID)
        let receive = "T: " + (String(data: data, encoding: .utf8) ?? "")
        msgs.append(receive)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.assistant.stop()
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
}

extension BluetoothViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return msgs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        cell.textLabel?.text = msgs[indexPath.row];
        return cell
    }
}

extension BluetoothViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text
        guard session.connectedPeers.count > 0 else {
            print("error: there is no peers for textSend")
            return true
        }
        guard let data = text?.data(using: String.Encoding.utf8) else {
            return true
        }
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
//            session.sendResource(at: <#T##URL#>, withName: <#T##String#>, toPeer: <#T##MCPeerID#>, withCompletionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
//            session.startStream(withName: <#T##String#>, toPeer: <#T##MCPeerID#>)
        } catch {
            print(error)
            return true
        }
        textField.text = nil
        textField.resignFirstResponder()
        msgs.append("Me: " +  (text ?? ""));
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
//        perform(<#T##aSelector: Selector##Selector#>, on: <#T##Thread#>, with: <#T##Any?#>, waitUntilDone: <#T##Bool#>)
        return true
    }
}
