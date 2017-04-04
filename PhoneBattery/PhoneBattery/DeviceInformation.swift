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
    
    
    
    
    

}
