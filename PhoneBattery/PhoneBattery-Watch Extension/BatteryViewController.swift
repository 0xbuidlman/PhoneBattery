//
//  BatteryViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 07.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

import WatchKit
import Foundation
import WatchConnectivity


class BatteryViewController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var batteryGroupItem: WKInterfaceGroup!
    @IBOutlet var batteryLevelLabel: WKInterfaceLabel!
    @IBOutlet var batteryStatusLabel: WKInterfaceLabel!
    
    @IBOutlet var circularGroupItem: WKInterfaceGroup!
    @IBOutlet var circularLevelLabel: WKInterfaceLabel!
    @IBOutlet var circularStatusLabel: WKInterfaceLabel!
    
    let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    var lastBatteryLevel = 0
    
    enum Interface {
        case battery
        case circular
    }
    
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
        
        self.circularGroupItem.setHidden(true)
        //self.batteryStatusLabel.setHidden(true)
        
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
        circularLevelLabel.setText("\(level)%")
        batteryLevelLabel.setText("\(level)%")
        
        if state == 0 {
            circularStatusLabel.setText("Unknown")
            batteryStatusLabel.setText("Unknown")
        } else if state == 1 {
            circularStatusLabel.setText("Left")
            batteryStatusLabel.setText("Left")
        } else if state == 2 {
            circularStatusLabel.setText("Charging")
            batteryStatusLabel.setText("Charging")
        } else if state == 3 {
            circularStatusLabel.setText("Full")
            batteryStatusLabel.setText("Full")
        }
        
        if lastBatteryLevel != level {
            
            circularGroupItem.setBackgroundImageNamed("CircularFrame-")
            self.circularGroupItem.startAnimatingWithImages(in: NSMakeRange(lastBatteryLevel, level+1), duration: 1, repeatCount: 1)
        }
        
        self.circularGroupItem.setHidden(true)
        //self.batteryStatusLabel.setHidden(true)
        lastBatteryLevel = level
        
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
