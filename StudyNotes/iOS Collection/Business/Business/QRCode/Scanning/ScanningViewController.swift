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
    
    @IBOutlet weak var scanBackView: UIView!
    
    @IBOutlet weak var scanFrameBackView: UIImageView!
    
    @IBOutlet weak var toBottom: NSLayoutConstraint!
    
//    var session = AVCaptureSession()
//    
//    lazy var input: AVCaptureDeviceInput? = {
//        if let device = AVCaptureDevice.default(for: .video) {
//            do {
//                return try AVCaptureDeviceInput(device: device)
//            } catch {
//                print(error)
//                return nil
//            }
//        }
//        return nil
//    }()
//    
//    lazy var output: AVCaptureMetadataOutput = {
//        let output = AVCaptureMetadataOutput()
//        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        return output
//    }()
//    
//    lazy var preLayer: AVCaptureVideoPreviewLayer = {
//        let preLayer = AVCaptureVideoPreviewLayer(session: session)
//        view.layer.insertSublayer(preLayer, at: 0)
//        return preLayer
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scanning"
        setInit()
        beginAnimation()
        //        beginScan()
        QRCodeTool.shared.scanningQRCode(inView: view) { (resultStr) in
            print(resultStr)
            if let lastStr = resultStr.last, let url = URL(string: lastStr) {
                if lastStr.contains("http://") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        QRCodeTool.shared.setInterstRect(sourceFrame: scanBackView.frame)
        QRCodeTool.shared.isDrawFlag = true
    }
}

//extension ScanningViewController: AVCaptureMetadataOutputObjectsDelegate {
//    
//    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
//        print("扫描到结果")
//        removeQRCodeFrame()
//        for obj in metadataObjects {
//            if let resultObj = obj as? AVMetadataMachineReadableCodeObject {
//                drawQRCodeFrame(obj: resultObj)
//                print(resultObj.stringValue ?? "")
//            }
//        }
//    }
//}

extension ScanningViewController {
    
//    func drawQRCodeFrame(obj: AVMetadataMachineReadableCodeObject) {
//        //corners 坐标想要使用 需要进行转换
//        if let resultObj = preLayer.transformedMetadataObject(for: obj) as? AVMetadataMachineReadableCodeObject {
//            print(resultObj.corners)
//            let layer = CAShapeLayer()
//            layer.strokeColor = UIColor.red.cgColor
//            layer.fillColor = UIColor.clear.cgColor
//            layer.lineWidth = 6
//            let path = UIBezierPath()
//            let pointCount = resultObj.corners.count
//            for i in 0..<pointCount {
//                let point = resultObj.corners[i]
//                if i == 0 {
//                    path.move(to: point)
//                } else {
//                    path.addLine(to: point)
//                }
//            }
//            path.close()
//            layer.path = path.cgPath
//            preLayer.addSublayer(layer)
//        }
//    }
//    
//    func removeQRCodeFrame() {
//        guard let subLayers = preLayer.sublayers else {return}
//        for layer in subLayers {
//            if layer is CAShapeLayer {
//                layer.removeFromSuperlayer()
//            }
//        }
//    }
    
//    func beginScan() {
//        if let input = input {
//            if session.canAddInput(input) && session.canAddOutput(output) {
//                session.addInput(input)
//                session.addOutput(output)
//                //            output.availableMetadataObjectTypes
//                output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
//            }
//        }
//        let bounds = UIScreen.main.bounds
//        let x = scanBackView.frame.origin.x / bounds.size.width
//        let y = scanBackView.frame.origin.y / bounds.size.height
//        let w = scanBackView.frame.size.width / bounds.size.width
//        let h = scanBackView.frame.size.height / bounds.size.height
//        output.rectOfInterest = CGRect(x: y, y: x, width: h, height: w)
//        session.startRunning()
//        preLayer.frame = view.bounds
//    }
    
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
