//
//  DeviceInformation.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 04.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class DeviceInformation: NSObject {
    
    class var buildNumber: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    class var versionNumber: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    class var hardwareIdentifier: String {
        if let key = "hw.machine".cString(using: String.Encoding.utf8) {
            var size: Int = 0
            sysctlbyname(key, nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: Int(size))
            sysctlbyname(key, &machine, &size, nil, 0)
            return String(cString:machine)
        }
        return "Unknown identifier"
    }
    
}
