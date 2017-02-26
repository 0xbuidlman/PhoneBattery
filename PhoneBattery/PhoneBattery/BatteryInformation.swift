//
//  BatteryInformation.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 21/02/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class BatteryInformation: NSObject {
    
    let device = UIDevice.current
    
    var batteryState: UIDeviceBatteryState {
        return device.batteryState
    }
    
    var batteryLevel: Int {
        return Int(device.batteryLevel * 100)
    }
    
    override init() {
        super.init()
        
        device.isBatteryMonitoringEnabled = true
    }

}
