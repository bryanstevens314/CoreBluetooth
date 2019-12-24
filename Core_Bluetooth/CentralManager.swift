//
//  CentralManager.swift
//  Core_Bluetooth
//
//  Created by Bryan Stevens on 1/29/19.
//  Copyright © 2019 IGMOTIVE. All rights reserved.
//

import UIKit
import CoreBluetooth

var sharedCentralManager = CentralManager()
var discoveredPeripherals = NSMutableArray()
var connectedPeripgerals = NSMutableDictionary()

class CentralManager: NSObject {

    var blueToothManager: CBCentralManager!
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var Data_Display: DataDisplay?
    
    class var centralManager: CentralManager {
        
        return CentralManager()
        
    }
    
    override init() {
        
        super.init()
        blueToothManager = CBCentralManager(delegate: self, queue: nil);
        Data_Display = storyboard.instantiateViewController(withIdentifier: "Data_Dispaly") as? DataDisplay
    }

    func connectToPeripheral(peripheral:CBPeripheral) {
        
        blueToothManager.connect(peripheral)
        
    }
    
    func startScanning(){
        
        let humanInterfaceDevice = CBUUID(string:"0x1812")
        blueToothManager.scanForPeripherals(withServices:nil)
        
    }
}

extension CentralManager: CBCentralManagerDelegate,CBPeripheralDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")
        case .unauthorized:
            print("central.state is .unauthorized")
        case .poweredOff:
            print("central.state is .poweredOff")
        case .poweredOn:
            print("central.state is .poweredOn")
        }
    }
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        print("Connected!")
        connectedPeripgerals.setValue(initialPeripheralDict(peripheral: peripheral), forKey: peripheral.identifier.uuidString)
        peripheral.discoverServices(nil)
    }
    
    func initialPeripheralDict(peripheral: CBPeripheral) -> NSMutableDictionary{
        
        peripheral.delegate = self;
        let dict = NSMutableDictionary()
        dict.setValue(peripheral, forKey: "peripheral")
        return dict
        
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        print(peripheral);
        if (!discoveredPeripherals.contains(peripheral)){
            discoveredPeripherals.add(peripheral)
            table?.reloadData();
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        guard let services = peripheral.services else { return }
        let dict = retrievePeripheralDict(peripheral: peripheral)
        dict.setValue(services, forKey: "services")
        dict.setValue(NSMutableDictionary(), forKey: "characteristics")
        connectedPeripgerals.setValue(dict, forKey: peripheral.identifier.uuidString)
        for service in services {
            print(service.uuid.uuidString)
             peripheral.discoverCharacteristics(nil, for: service)
        }
       
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        guard let characteristics = service.characteristics else { return }
        let dict = retrievePeripheralDict(peripheral: peripheral)
        let charDict = retrieveCharacteristicsFor(peripheral: peripheral)
        charDict.setValue(characteristics, forKey: service.uuid.uuidString)
        connectedPeripgerals.setValue(dict, forKey: peripheral.identifier.uuidString)
        Data_Display?.displayConnectedPeripheral()
        
    }
    
    func retrievePeripheralDict(peripheral: CBPeripheral) -> NSMutableDictionary{
        
        return connectedPeripgerals.value(forKey: peripheral.identifier.uuidString) as! NSMutableDictionary
    }
    
    func retrieveCharacteristicsFor(peripheral: CBPeripheral) -> NSMutableDictionary{
        
        let dict = retrievePeripheralDict(peripheral: peripheral)
        return dict.value(forKey: "characteristics") as! NSMutableDictionary
    }
    func peripheral(_ peripheral: CBPeripheral, didDiscoverDescriptorsFor characteristic: CBCharacteristic, error: Error?) {
        print(characteristic)
    }

}
