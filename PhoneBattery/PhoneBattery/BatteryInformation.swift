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
    
    var batteryState: Int {
        return device.batteryState.rawValue
    }
    
    var batteryLevel: Int {
        return Int(device.batteryLevel * 100)
    }
    
    override init() {
        super.init()
        
        device.isBatteryMonitoringEnabled = true
    }
    
    func stringForBatteryState(state: Int) -> String {
        if state == 1 {
            return "Unplugged"
        } else if state == 2 {
            return "Charging"
        } else if state == 3 {
            return "Full"
        } else {
            return "Unknown"
        }
    }
}
