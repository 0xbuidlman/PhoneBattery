//
//  InterfaceController.swift
//  PhoneBattery-Watch Extension
//
//  Created by Marcel Voß on 05.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var levelLabel: WKInterfaceLabel!
    @IBOutlet var groupItem: WKInterfaceGroup!
    let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if WCSession.isSupported() {
            session?.delegate = self
            session?.activate()
        }
    }
    
    override init() {
        super.init()
        
        if WCSession.isSupported() {
            session?.delegate = self
            session?.activate()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        setTitle("PhoneBattery")
        groupItem.setBackgroundImageNamed("CircularFrame-")

        if let reachable = session?.isReachable, let theSession = session {
            if reachable {
                
                theSession.sendMessage(["requiresUpdate": true], replyHandler: { (reply) in
                    // handle reply from iPhone
                    
                    if let batteryLevel = reply["batteryLevel"] as? Int,  let batteryState = reply["batteryState"] as? Int{
                        
                        DispatchQueue.main.sync {
                            self.updateInterface(level: batteryLevel, state: batteryState)
                        }
                        
                    }
                    
                }, errorHandler: { (error) in
                    // handle errors
                    
                })
            }
        }
    }
    
    func updateInterface(level: Int, state: Int) {
        levelLabel.setText("Level: \(level)%")
        groupItem.setBackgroundImageNamed("CircularFrame-")
        self.groupItem.startAnimatingWithImages(in: NSMakeRange(0, level+1), duration: 1, repeatCount: 1)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage
        message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        
        
        
    }
    
    
}
