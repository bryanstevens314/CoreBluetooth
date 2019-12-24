//
//  DataDisplay.swift
//  Core_Bluetooth
//
//  Created by Bryan Stevens on 1/30/19.
//  Copyright © 2019 IGMOTIVE. All rights reserved.
//

import UIKit

class DataDisplay: UIViewController {
    @IBOutlet weak var text_view: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayConnectedPeripheral(){
        var fullDict = " "
        
        for (x, y) in connectedPeripgerals {

            print(x)
            print(y)
            fullDict += "(\(x): \(y))\n"
        }
        
        self.text_view?.text = fullDict
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
