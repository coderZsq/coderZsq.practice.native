//
//  RankViewController.swift
//  LiveBroadcast
//
//  Created by 朱双泉 on 2018/12/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import AVFoundation
//import GPUImage

class RankViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
//    fileprivate lazy var camera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
//    fileprivate lazy var camera2 = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.hd1280x720.rawValue, cameraPosition: .back)
//    fileprivate lazy var filter = GPUImageBrightnessFilter()
    
    fileprivate lazy var session = AVCaptureSession()
    fileprivate var videoOutput: AVCaptureVideoDataOutput?
    fileprivate var previewLayer: AVCaptureVideoPreviewLayer?
    fileprivate var videoInput: AVCaptureDeviceInput?
    fileprivate var movieOutput: AVCaptureMovieFileOutput?
    fileprivate var fileURL: URL? {
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/abc.mp4"
        do {
            if FileManager.default.fileExists(atPath: filePath) {
                try FileManager.default.removeItem(atPath: filePath)
            }
            return URL(fileURLWithPath: filePath)
        } catch {
            print(error)
            return nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideoInputOutput()
        setupAudioInputOutput()
        setupMovieFileOutput()

//        filter.brightness = 0.7
//        camera?.addTarget(filter)
        
//        camera2?.outputImageOrientation = .portrait
//        camera2?.addTarget(filter)
//        camera2?.delegate = self
//        let showView = GPUImageView(frame: view.bounds)
//        view.insertSubview(showView, at: 0)
//        filter.addTarget(showView)
//        camera2?.startCapture()
    }

}

//extension RankViewController: GPUImageVideoCameraDelegate {
//
//    func willOutputSampleBuffer(_ sampleBuffer: CMSampleBuffer!) {
//        print(#function, #line)
//    }
//
//}

extension RankViewController {
    
    @IBAction func startCapturing(_ sender: UIButton) {
        
//        camera?.capturePhotoAsImageProcessedUp(toFilter: filter, withCompletionHandler: { (image, error) in
//            DispatchQueue.main.async {
//                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
//                self.imageView.image = image
//                self.camera?.stopCapture()
//            }
//        })

        session.startRunning()
        if let fileURL = fileURL {
            movieOutput?.startRecording(to: fileURL, recordingDelegate: self)
        }
        setupPreviewLayer()
    }
    
    @IBAction func stopCapturing(_ sender: UIButton) {
        movieOutput?.stopRecording()
        session.stopRunning()
        previewLayer?.removeFromSuperlayer()
    }
    
    @IBAction func rotateCamera(_ sender: UIButton) {
        guard let videoInput = videoInput else { return }
        let oritation: AVCaptureDevice.Position = videoInput.device.position == .front ? .back : .front
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTelephotoCamera, .builtInTrueDepthCamera, .builtInWideAngleCamera], mediaType: AVMediaType.video, position: oritation)
        guard let device = discoverySession.devices.filter({ $0.position == oritation }).first else { return }
        guard let newInput = try? AVCaptureDeviceInput(device: device) else { return }
        session.beginConfiguration()
        session.removeInput(videoInput)
        if session.canAddInput(newInput) {
            session.addInput(newInput)
        }
        session.commitConfiguration()
        self.videoInput = newInput
    }
}

extension RankViewController {
    
    fileprivate func setupVideoInputOutput() {
        guard let device = AVCaptureDevice.default(.builtInTrueDepthCamera, for: AVMediaType.video, position: .front) else { return }
//        let devices = AVCaptureDevice.devices()
//        guard let device = devices.filter({ $0.position == .front }).first else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }
        videoInput = input
        let output = AVCaptureVideoDataOutput()
        videoOutput = output
        let queue = DispatchQueue.global()
        output.setSampleBufferDelegate(self, queue: queue)
        addInputOutputToSession(input, output)
    }
    
    fileprivate func setupAudioInputOutput() {
        guard let device = AVCaptureDevice.default(for: .audio) else { return }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return }
        let output = AVCaptureAudioDataOutput()
        let queue = DispatchQueue.global()
        output.setSampleBufferDelegate(self, queue: queue)
        addInputOutputToSession(input, output)
    }
    
    private func addInputOutputToSession(_ input: AVCaptureInput, _ output: AVCaptureOutput) {
        session.beginConfiguration()
        if session.canAddInput(input) {
            session.addInput(input)
        }
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        session.commitConfiguration()
    }
    
    fileprivate func setupPreviewLayer() {
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.bounds
        self.previewLayer = previewLayer
        view.layer.insertSublayer(previewLayer, at: 0)
    }
    
    fileprivate func setupMovieFileOutput() {
        let fileOutput = AVCaptureMovieFileOutput()
        movieOutput = fileOutput
        let connection = fileOutput.connection(with: .video)
        connection?.automaticallyAdjustsVideoMirroring = true
        if session.canAddOutput(fileOutput) {
            session.addOutput(fileOutput)
        }
    }
    
}

extension RankViewController: AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate {
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if videoOutput?.connection(with: .video) == connection {
            print("采集视频数据")
        } else {
            print("采集音频数据")
        }
    }
    
}

extension RankViewController: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        print("开始写入文件")
    }
        
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("完成写入文件")
    }
    
}
