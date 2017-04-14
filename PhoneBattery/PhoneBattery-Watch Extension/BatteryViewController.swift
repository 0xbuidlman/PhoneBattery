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

class BatteryViewController: WKInterfaceController {
    
    @IBOutlet var batteryGroupItem: WKInterfaceGroup!
    @IBOutlet var batteryLevelLabel: WKInterfaceLabel!
    @IBOutlet var batteryStatusLabel: WKInterfaceLabel!
    
    @IBOutlet var circularGroupItem: WKInterfaceGroup!
    @IBOutlet var circularLevelLabel: WKInterfaceLabel!
    @IBOutlet var circularStatusLabel: WKInterfaceLabel!
    
    var lastBatteryLevel = 0
    let settings = SettingsModel()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        
        hideAlternativeInterface()
        wantsUpdate()
    }
    
    override init() {
        super.init()
        
        hideAlternativeInterface()
        wantsUpdate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(interfaceNeedsUpdate), name: NSNotification.Name("WatchInterfaceDidChange"), object: nil)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        setTitle("PhoneBattery")
        wantsUpdate()
    }
    
    func hideAlternativeInterface() {
        batteryLevelLabel.setText("")
        batteryStatusLabel.setText("")
        
        if settings.useCircularIndicator {
            self.batteryGroupItem.setHidden(true)
            self.batteryStatusLabel.setHidden(true)
            
            self.circularGroupItem.setHidden(false)
        } else {
            self.circularGroupItem.setHidden(true)
            
            self.batteryGroupItem.setHidden(false)
            self.batteryStatusLabel.setHidden(false)
        }
    }
    
    func wantsUpdate() {
        if let reachable = WatchManager.sharedInstance.session?.isReachable, let theSession = WatchManager.sharedInstance.session {
            if reachable {
                theSession.sendMessage(["RequiresUpdate": true], replyHandler: { (reply) in
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
        hideAlternativeInterface()
        
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
        
        let duration: TimeInterval = lastBatteryLevel > level ? -1 : 1
        if lastBatteryLevel != level {
            if settings.useCircularIndicator {
                circularGroupItem.setBackgroundImageNamed("CircularFrame-")
                circularGroupItem.startAnimatingWithImages(in: NSMakeRange(lastBatteryLevel, level+1), duration: duration, repeatCount: 1)
            } else {
                batteryGroupItem.setBackgroundImageNamed("BatteryFrame-")
                batteryGroupItem.startAnimatingWithImages(in: NSMakeRange(lastBatteryLevel, level+1), duration: duration, repeatCount: 1)
            }
        }
        
        lastBatteryLevel = level
    }
    
    func interfaceNeedsUpdate() {
        lastBatteryLevel = 0
        wantsUpdate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
}
