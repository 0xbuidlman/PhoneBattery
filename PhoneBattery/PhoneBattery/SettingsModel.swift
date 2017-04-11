//
//  SettingsModel.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 24/02/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

/// A class for accessing NSUserDefaults values by property names.
class SettingsModel: NSObject {
    
    let userDefaults = UserDefaults.standard
    
    var hasRunBefore: Bool {
        get {
            return userDefaults.bool(forKey: "HasRunBefore")
        } set {
            userDefaults.set(newValue, forKey: "HasRunBefore")
            userDefaults.synchronize()
        }
    }
    
    var onboardingComplete: Bool {
        get {
            return userDefaults.bool(forKey: "OnboardingComplete")
        } set {
            userDefaults.set(newValue, forKey: "OnboardingComplete")
            userDefaults.synchronize()
        }
    }
    
    var useCircularIndicator: Bool {
        get {
            return userDefaults.bool(forKey: "UseCircularIndicator")
        } set {
            userDefaults.set(newValue, forKey: "UseCircularIndicator")
            userDefaults.synchronize()
        }
    }
    
    var useStatusNotifications: Bool {
        get {
            return userDefaults.bool(forKey: "UseStatusNotifications")
        } set {
            userDefaults.set(newValue, forKey: "UseStatusNotifications")
            userDefaults.synchronize()
        }
    }
    
    
    func setDefaults() -> Bool {
        if hasRunBefore  {
            // Make sure to not overwrite previously set defaults
            return false
        } else {
            
            useStatusNotifications = true
            useCircularIndicator = true
            onboardingComplete = false
            
            hasRunBefore = true
            userDefaults.synchronize()
            
            return true
        }
    }
    
    
    
    
}
