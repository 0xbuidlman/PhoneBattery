//
//  WatchManager.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 14.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import WatchKit
import WatchConnectivity

class WatchManager: NSObject, WCSessionDelegate {
    
    /// Singleton
    static let sharedInstance = WatchManager()
    
    let settings = SettingsModel()
    let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    func setup() -> Bool {
        // Do all inital setup required for data transfers to the phone here
        
        if WCSession.isSupported() {
            session?.delegate = self
            session?.activate()
            
            return true
        }
        return false
    }
    
    // MARK: WCSessionDelegate
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage
        message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        
        
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        if let useCircularInterface = applicationContext["CircularInterfaceActive"] as? Bool {
            settings.useCircularIndicator = useCircularInterface
            NotificationCenter.default.post(name: NSNotification.Name("WatchInterfaceDidChange"), object: nil)
        }
        
    }

}
