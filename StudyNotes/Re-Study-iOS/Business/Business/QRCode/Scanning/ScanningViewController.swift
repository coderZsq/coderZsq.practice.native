//
//  ScanningViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation

class ScanningViewController: UIViewController {
    
    @IBOutlet weak var scanFrameBackView: UIImageView!
    
    @IBOutlet weak var toBottom: NSLayoutConstraint!
    
    var session = AVCaptureSession()
    
    lazy var input: AVCaptureDeviceInput? = {
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                return try AVCaptureDeviceInput(device: device)
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }()
    
    lazy var output: AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return output
    }()
    
    lazy var preLayer: AVCaptureVideoPreviewLayer = {
        let preLayer = AVCaptureVideoPreviewLayer(session: session)
        view.layer.insertSublayer(preLayer, at: 0)
        return preLayer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scanning"
        setInit()
        view.backgroundColor = .red
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        beginAnimation()
        beginScan()
    }
}

extension ScanningViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("扫描到结果")
    }
}

extension ScanningViewController {
    
    func beginScan() {
        if let input = input {
            if session.canAddInput(input) && session.canAddOutput(output) {
                session.addInput(input)
                session.addOutput(output)
                //            output.availableMetadataObjectTypes
                output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            }
        }
        session.startRunning()
        preLayer.frame = CGRect(x: 0, y: -600, width: view.width, height: 1000)
    }
    
    func setInit() {
        if let image = UIImage(named: "qrcode_border") {
            scanFrameBackView.image = image.stretchableImage(withLeftCapWidth: Int(image.size.width * 0.5), topCapHeight: Int(image.size.height * 0.5))
        }
    }
    
    func beginAnimation() {
        toBottom.constant = scanFrameBackView.frame.size.height
        view.layoutIfNeeded()
        toBottom.constant = -scanFrameBackView.frame.size.height
        UIView.animate(withDuration: 1.5) {
            UIView.setAnimationRepeatCount(Float.infinity)
            self.view.layoutIfNeeded()
        }
    }
}
