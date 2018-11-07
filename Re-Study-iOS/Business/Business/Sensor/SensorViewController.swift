//
//  SensorViewController.swift
//  Business
//
//  Created by 朱双泉 on 2018/11/3.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import CoreMotion

class SensorViewController: UIViewController {

    let motionManager = CMMotionManager()
    let stepCounter = CMStepCounter()
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIDevice.current.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(proximityStateDidChange), name: UIDevice.proximityStateDidChangeNotification, object: nil)
        
        motionManager.accelerometerUpdateInterval = 1 / 3
        
        if !motionManager.isAccelerometerAvailable {
            print("你的硬件坏了")
            return
        }
        motionManager.startAccelerometerUpdates() //拉模式
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            if let data = data { //推模式
                print(data.acceleration)
            }
        }
        
        if #available(iOS 8.0, *) {
            if !CMPedometer.isStepCountingAvailable() {
                print("计步器不可用")
                return
            }
            
            let now = Date(timeIntervalSinceNow: 0)
            pedometer.startUpdates(from: now) { (data, error) in
                print(data ?? "")
                //            data?.numberOfSteps
                //            data?.distance
                //            data?.floorsAscended
                //            data?.floorsDescended
                //            data?.currentPace
                //            data?.currentCadence
            }
        } else {
            if !CMStepCounter.isStepCountingAvailable() {
                print("计步器失效")
                return
            }
            
            let start = Date(timeIntervalSinceNow: -24 * 60 * 60)
            let to = Date(timeIntervalSinceNow: 0)
            stepCounter.queryStepCountStarting(from: start, to: to, to: OperationQueue.main) { (count, error) in
                print(count)
            }
        }
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("摇一摇开始")
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("摇一摇结束")
    }
    
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("摇一摇取消")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(motionManager.accelerometerData ?? "")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    func proximityStateDidChange() {
        if UIDevice.current.proximityState {
            print("有物体靠近")
        } else{
            print("有物体离开")
        }
    }
}
