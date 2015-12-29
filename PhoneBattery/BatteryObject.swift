//
//  BatteryObject.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 23.10.15.
//  Copyright © 2015 Marcel Voss. All rights reserved.
//

import UIKit

class BatteryObject: NSObject {
    
    let batteryLevel : Int
    let batteryState : Int
    
    init(level: Int, state: Int) {
        batteryLevel = level
        batteryState = state
        
        super.init()
    }
    

}
