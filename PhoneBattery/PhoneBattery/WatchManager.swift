//
//  WatchManager.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 14.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import WatchConnectivity

class WatchManager: NSObject, WCSessionDelegate {
    
    /// Singleton
    static let sharedInstance = WatchManager()
    
    let battery = BatteryInformation()
    let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    func setup() -> Bool {
        // Do all inital setup required for data transfers to the Watch here
        
        NotificationCenter.default.addObserver(self, selector: #selector(sendBatteryInformation),
                                               name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendBatteryInformation),
                                               name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(sendBatteryInformation),
                                               name: NSNotification.Name.NSProcessInfoPowerStateDidChange, object: nil)
        
        if WCSession.isSupported() {
            session?.delegate = self
            session?.activate()
            
            return true
        }
        return false
    }
    
    func sendBatteryInformation() {
        
        if let reachable = session?.isReachable, let theSession = WatchManager.sharedInstance.session {
            if reachable {
                
                let applicationData = ["batteryLevel": battery.batteryLevel,
                                       "batteryState": battery.batteryState,
                                       "lowPowerModeActive": battery.lowPowerModeEnabled] as [String : Any]
                
                theSession.sendMessage(applicationData, replyHandler: nil, errorHandler: { (error) in
                    // TODO: Add error hanlding
                    
                    
                })
                
            }
        }
        
        
    }
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage
        message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        if let requiresUpdate = message["RequiresUpdate"] as? Bool {
            if requiresUpdate {
                
                let applicationData = ["batteryLevel": battery.batteryLevel,
                                       "batteryState": battery.batteryState,
                                       "lowPowerModeActive": battery.lowPowerModeEnabled] as [String : Any]
                
                replyHandler(applicationData as [String : Any])
                
            }
        }
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        if let _ = applicationContext["CircularInterfaceActive"] {
            NotificationCenter.default.post(name: NSNotification.Name("WatchInterfaceDidChange"), object: nil)
        }
        
    }

}
