//
//  BluetoothViewController2.swift
//  Business
//
//  Created by 朱双泉 on 2018/12/6.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit
import CoreBluetooth

let UUID1 = "FFE0"
let UUID2 = "FFE1"

let readCharUUID = "F0E0"
let readWriteCharUUID = "F0E1"
let notifyCharUUID = "F0E2"

class BluetoothViewController2: UIViewController {

    var peripheral: CBPeripheral?
    
    lazy var services: [CBMutableService] = {
        
        let descriptor = CBMutableDescriptor(type: CBUUID(string: CBUUIDCharacteristicUserDescriptionString), value: "readCharDescriptorValue")
        let readChar = CBMutableCharacteristic(type: CBUUID(string: readCharUUID), properties: .read, value: "readChar".data(using: .utf8), permissions: .readable)
        readChar.descriptors = [descriptor]
        
        let readWriteChar = CBMutableCharacteristic(type: CBUUID(string: readWriteCharUUID), properties: [.read, .write], value: nil, permissions: [.readable, .writeable])
        
        let notifyChar = CBMutableCharacteristic(type: CBUUID(string: notifyCharUUID), properties: .notify, value: nil, permissions: [.readable, .writeable])

        let service1 = CBMutableService(type: CBUUID(string: UUID1), primary: true)
        service1.characteristics = [readChar, readWriteChar]
        let service2 = CBMutableService(type: CBUUID(string: UUID2), primary: true)
        service2.characteristics = [notifyChar]
        let services = [service1, service2]
        return services
    }()
    
    lazy var p_manager = CBPeripheralManager(delegate: self, queue: DispatchQueue.main, options: nil)
    
    lazy var c_manager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    
    func serve(services: [CBMutableService]) {
        _ = services.map {p_manager.add($0)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bluetooth"
        _ = p_manager
        _ = c_manager
    }
}

extension BluetoothViewController2: CBPeripheralManagerDelegate {
 
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        switch peripheral.state {
        case .poweredOff:
            print("poweredOff")
        case .poweredOn:
            print("poweredOn")
            serve(services: services)
            let advertisementJSON: [String : Any] = [
                CBAdvertisementDataLocalNameKey : "manager-localName",
                CBAdvertisementDataServiceUUIDsKey : [services.map{$0.uuid}],
                CBAdvertisementDataServiceDataKey : "测试数据".data(using: String.Encoding.utf8) ?? ""
                ]
            peripheral.startAdvertising(advertisementJSON)
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        print(service, error ?? "", #function, #line)
    }
}

extension BluetoothViewController2: CBCentralManagerDelegate {

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOff:
            print("poweredOff")
        case .poweredOn:
            print("poweredOn")
            central.scanForPeripherals(withServices: nil, options: nil)
        case .resetting:
            print("resetting")
        case .unauthorized:
            print("unauthorized")
        case .unknown:
            print("unknown")
        case .unsupported:
            print("unsupported")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        guard let localName = advertisementData[CBAdvertisementDataLocalNameKey] as? String, localName == "manager-localName" else {
            return
        }
        self.peripheral = peripheral
        central.stopScan()
        central.connect(peripheral, options: nil)
        print(central, peripheral, advertisementData, RSSI)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print(#function, #line)
        print(peripheral.services ?? "")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print(#function, #line)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print(#function, #line)
        c_manager.connect(peripheral, options: nil)
    }
}

extension BluetoothViewController2: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print(peripheral.services ?? "")
        _ = peripheral.services?.map{peripheral.discoverCharacteristics(nil, for: $0)}
        for service: CBService in peripheral.services! {
            if service.uuid.uuidString != "FFE0" && service.uuid.uuidString != "FFE1" {
                continue
            }
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print(service.characteristics?.map{$0.uuid} ?? "")
        _ = service.characteristics?.map{peripheral.readValue(for: $0)}
        _ = service.characteristics?.map{peripheral.discoverDescriptors(for: $0)}
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic.uuid , "is readed")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic.descriptors ?? "")
        _ = characteristic.descriptors?.map{peripheral.readValue(for: $0)}
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        print(#line, descriptor.uuid, descriptor.value ?? "", descriptor)
    }
}
