//
//  QRCodeTool.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/21.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation

typealias ScanResult = ([String]) -> ()

class QRCodeTool: NSObject {
    
    static let shared = QRCodeTool()
    
    var isDrawFlag = false
    
    private var session = AVCaptureSession()
    
    private lazy var input: AVCaptureDeviceInput? = {
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
    
    private lazy var output: AVCaptureMetadataOutput = {
        let output = AVCaptureMetadataOutput()
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        return output
    }()
    
    private lazy var preLayer: AVCaptureVideoPreviewLayer = {
        let preLayer = AVCaptureVideoPreviewLayer(session: session)
        return preLayer
    }()
    
    private var scanResult: ScanResult?
}

extension QRCodeTool {
    
    class func generatorQRCode(content: String, bigImageSize: CGFloat, smallIcon: UIImage? = nil, smallImageSize: CGFloat = 0) -> UIImage? {
        let strData = content.data(using: .utf8)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(strData, forKey: "inputMessage")
        //纠错率 L, M, Q, H
        filter?.setValue("M", forKey: "inputCorrectionLevel")
        if let ciImage = filter?.outputImage {
            let image = createBigImage(image: ciImage, size: bigImageSize)
            if let smallImage = smallIcon {
                return createImage(bigImage: image, smallImage: smallImage, sizeHW: smallImageSize)
            }
            return image
        }
        return nil
    }
    
    class func detectorQRCode(scourceImage: UIImage, isDrawQRCodeFrame: Bool) -> ([String], UIImage?) {
        let context = CIContext()
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        if
            let ciImage = CIImage(image: scourceImage),
            let features = detector?.features(in: ciImage) {
            var resultArray = [String]()
            var tempImage = scourceImage
            for feature in features {
                if let tempFeature = feature as? CIQRCodeFeature {
                    print(tempFeature.bounds)
                    print(tempFeature.messageString ?? "")
                    guard let messageString = tempFeature.messageString else {return ([], nil)}
                    resultArray.append(messageString)
                    if isDrawQRCodeFrame {
                        tempImage = drawQRCodeFrame(feature: tempFeature, toImage: tempImage) ?? UIImage()
                    }
                }
            }
            return (resultArray, tempImage)
        }
        return ([], nil)
    }
    
    func scanningQRCode(inView: UIView, resultBlock: ScanResult?) {
        scanResult = resultBlock
        if let input = input {
            if session.canAddInput(input) && session.canAddOutput(output) {
                session.addInput(input)
                session.addOutput(output)
                //            output.availableMetadataObjectTypes
                output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            }
        }
        session.startRunning()
        preLayer.frame = inView.bounds
        guard let sublayers = inView.layer.sublayers else {
            inView.layer.insertSublayer(preLayer, at: 0)
            return
        }
        if !sublayers.contains(preLayer) {
            inView.layer.insertSublayer(preLayer, at: 0)
        }
    }
    
    func setInterstRect(sourceFrame: CGRect) {
        let bounds = UIScreen.main.bounds
        let x = sourceFrame.origin.x / bounds.size.width
        let y = sourceFrame.origin.y / bounds.size.height
        let w = sourceFrame.size.width / bounds.size.width
        let h = sourceFrame.size.height / bounds.size.height
        output.rectOfInterest = CGRect(x: y, y: x, width: h, height: w)
    }
}

extension QRCodeTool: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("扫描到结果")
        
        removeQRCodeFrame()
        var resultStrs = [String]()
        for obj in metadataObjects {
            if
                let resultObj = obj as? AVMetadataMachineReadableCodeObject,
                let stringValue = resultObj.stringValue {
                resultStrs.append(stringValue)
                if isDrawFlag {
                    drawQRCodeFrame(obj: resultObj)
                }
                print(resultObj.stringValue ?? "")
            }
        }
        scanResult?(resultStrs)
    }
}

extension QRCodeTool {
    
    private func drawQRCodeFrame(obj: AVMetadataMachineReadableCodeObject) {
        //corners 坐标想要使用 需要进行转换
        if let resultObj = preLayer.transformedMetadataObject(for: obj) as? AVMetadataMachineReadableCodeObject {
            print(resultObj.corners)
            let layer = CAShapeLayer()
            layer.strokeColor = UIColor.red.cgColor
            layer.fillColor = UIColor.clear.cgColor
            layer.lineWidth = 6
            let path = UIBezierPath()
            let pointCount = resultObj.corners.count
            for i in 0..<pointCount {
                let point = resultObj.corners[i]
                if i == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
            layer.path = path.cgPath
            preLayer.addSublayer(layer)
        }
    }
    
    private func removeQRCodeFrame() {
        guard let subLayers = preLayer.sublayers else {return}
        for layer in subLayers {
            if layer is CAShapeLayer {
                layer.removeFromSuperlayer()
            }
        }
    }
    
    private class func createImage(bigImage: UIImage?, smallImage: UIImage?, sizeHW: CGFloat) -> UIImage? {
        if
            let size = bigImage?.size,
            let bigImage = bigImage,
            let smallImage = smallImage {
            UIGraphicsBeginImageContext(size)
            bigImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let x = (size.width - sizeHW) * 0.5
            let y = (size.height - sizeHW) * 0.5
            smallImage.draw(in: CGRect(x: x, y: y, width: sizeHW, height: sizeHW))
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
    private class func createBigImage(image: CIImage, size: CGFloat) -> UIImage? {
        let extent = image.extent.integral
        let scale = min(size / extent.width, size / extent.height)
        let width = extent.width * scale
        let height = extent.height * scale
        let space = CGColorSpaceCreateDeviceGray()
        if let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: space, bitmapInfo: 0) {
            bitmapRef.interpolationQuality = .none
            bitmapRef.scaleBy(x: scale, y: scale)
            let context = CIContext(options: nil)
            if let bitmapImage = context.createCGImage(image, from: extent) {
                bitmapRef.draw(bitmapImage, in: extent)
            }
            if let scaledImage = bitmapRef.makeImage() {
                return UIImage(cgImage: scaledImage)
            }
        }
        return nil
    }
    
    private class func drawQRCodeFrame(feature: CIQRCodeFeature, toImage: UIImage) -> UIImage? {
        let bounds = feature.bounds
        let size = toImage.size
        UIGraphicsBeginImageContext(size)
        toImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: 1, y: -1)
        context?.translateBy(x: 0, y: -size.height)
        let path = UIBezierPath(rect: bounds)
        path.lineWidth = 10
        UIColor.red.set()
        path.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
