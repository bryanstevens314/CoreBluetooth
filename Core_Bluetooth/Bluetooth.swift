//
//  Bluetooth.swift
//  Core_Bluetooth
//
//  Created by Bryan Stevens on 1/29/19.
//  Copyright © 2019 IGMOTIVE. All rights reserved.
//

import UIKit
import CoreBluetooth


class Bluetooth: UIViewController {
    @IBOutlet weak var table_Container: UIView!
    @IBOutlet weak var search_Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharedCentralManager = CentralManager()

    }
    
    @IBAction func peripheralSearch(_ sender: Any) {
        if(!sharedCentralManager.blueToothManager.isScanning){
            resetDiscoveredDeviceData()
            updateElementsInView()
            sharedCentralManager.startScanning()
            startTimerWith(time:5.0)
        }
        
    }
    func resetDiscoveredDeviceData(){
        discoveredPeripherals = NSMutableArray()
        table?.reloadData()
    }
    
    func updateElementsInView(){
        self.search_Button.currentTitle == "Scan For Devices" ?
            self.search_Button.setTitle("Scan For Devices", for: .normal) : self.search_Button.setTitle("Scanning..." , for: .normal)
        self.search_Button.isUserInteractionEnabled = self.search_Button.isUserInteractionEnabled == true ?
            false: true
        self.table_Container.isHidden = self.table_Container.isHidden == true && false;
    }
    
    func startTimerWith(time: Double){
        Timer.scheduledTimer(withTimeInterval: time, repeats: true) { timer in
            sharedCentralManager.blueToothManager.stopScan();
            timer.invalidate();
            self.updateElementsInView()
            print("Timer Finished")
        }
    }
}


