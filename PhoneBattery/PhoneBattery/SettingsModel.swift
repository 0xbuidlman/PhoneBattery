//
//  SettingsModel.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 24/02/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class SettingsModel: NSObject {
    
    let userDefaults = UserDefaults.standard
    
    var hasRunBefore: Bool {
        get {
            return userDefaults.bool(forKey: "HasRunBefore")
        } set {
            userDefaults.set(newValue, forKey: "HasRunBefore")
        }
    }
    
    
    
    
}
