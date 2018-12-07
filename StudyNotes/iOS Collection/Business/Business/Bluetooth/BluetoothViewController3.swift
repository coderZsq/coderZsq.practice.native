//
//  BluetoothViewController3.swift
//  Business
//
//  Created by 朱双泉 on 2018/12/7.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class BluetoothViewController3: UIViewController {

    lazy var beaconRegion: CLBeaconRegion = {
        let uuid = UUID(uuidString: "")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 2, minor: 3, identifier: "")
        return beaconRegion
    }()
    
    lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    var p_manager: CBPeripheralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "iBeacon";
        manager.startMonitoring(for: beaconRegion)
        p_manager = CBPeripheralManager(delegate: self, queue: nil)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: startAdvNoteName), object: nil, queue: nil) { (note) in
            if let beaconRegion = note.object as? CLBeaconRegion,
                let regionInfo = beaconRegion.peripheralData(withMeasuredPower: 0) as? [String : Any] {
                if (self.p_manager.state == .poweredOn) {
                    self.p_manager.startAdvertising(regionInfo)
                }
            }
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name(stopAdvNoteName), object: nil, queue: nil) { (note) in
            if self.p_manager.state == .poweredOn {
                self.p_manager.stopAdvertising()
            }
        }
    }
}

extension BluetoothViewController3: CBPeripheralManagerDelegate {
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {

        }
    }
}

let startAdvNoteName = "startAdvNoteName"
let stopAdvNoteName = "stopAdvNoteName"

extension BluetoothViewController3: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region == beaconRegion {
            manager.startRangingBeacons(in: beaconRegion)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: startAdvNoteName), object: beaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region == beaconRegion {
            manager.stopRangingBeacons(in: beaconRegion)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: stopAdvNoteName), object: beaconRegion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if region == beaconRegion {
            for beacon in beacons {
                print(beacon.proximity, beacon.minor, beacon.major)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
        
    }
}
