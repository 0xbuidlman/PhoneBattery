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
    }
    
    override init() {
        super.init()
        
        hideAlternativeInterface()

        NotificationCenter.default.addObserver(self, selector: #selector(interfaceNeedsUpdate), name: NSNotification.Name("WatchInterfaceDidChange"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateBatteryInformation(notification:)), name: NSNotification.Name("BatteryInformationUpdated"), object: nil)
    }
    
    func updateBatteryInformation(notification: Notification) {
        let batteryInformation = notification.userInfo
        
        if let batteryLevel = batteryInformation?["batteryLevel"] as? Int, let batteryState = batteryInformation?["batteryState"] as? Int, let lowPowerModeActive = batteryInformation?["lowPowerModeActive"] as? Bool {
            
            DispatchQueue.main.sync {
                updateInterface(level: batteryLevel, state: batteryState, lowPowerModeActive: lowPowerModeActive)
            }
        }
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
                    
                    if let batteryLevel = reply["batteryLevel"] as? Int,  let batteryState = reply["batteryState"] as? Int, let lowPowerModeActive = reply["lowPowerModeActive"] as? Bool {
                        
                        DispatchQueue.main.sync {
                            self.updateInterface(level: batteryLevel, state: batteryState, lowPowerModeActive: lowPowerModeActive)
                        }
                        
                    }
                }, errorHandler: { (error) in
                    // handle errors
                    
                })
            }
        }
    }
    
    func updateInterface(level: Int, state: Int, lowPowerModeActive: Bool) {
        hideAlternativeInterface()
        
        circularLevelLabel.setText("\(level)%")
        batteryLevelLabel.setText("\(level)%")
        
        if state == 0 {
            circularStatusLabel.setText(NSLocalizedString("BATTERY_UNKNOWN", comment: ""))
            batteryStatusLabel.setText(NSLocalizedString("BATTERY_UNKNOWN", comment: ""))
        } else if state == 1 {
            circularStatusLabel.setText("BATTERY_LEFT_SHORT")
            batteryStatusLabel.setText(NSLocalizedString("BATTERY_LEFT_LONG", comment: ""))
        } else if state == 2 {
            circularStatusLabel.setText("BATTERY_CHARGING_SHORT")
            batteryStatusLabel.setText(NSLocalizedString("BATTERY_CHARGING_LONG", comment: ""))
        } else if state == 3 {
            circularStatusLabel.setText("BATTERY_FULL_SHORT")
            batteryStatusLabel.setText(NSLocalizedString("BATTERY_FULL_LONG", comment: ""))
        }
        
        // FIXME: Animation animates wrong or showes wrong image
        let duration: TimeInterval = lastBatteryLevel > level ? -1 : 1
        
        if lastBatteryLevel != level {
            if settings.useCircularIndicator {
                if lowPowerModeActive {
                    circularGroupItem.setBackgroundImageNamed("CircularLowPowerFrame-")
                } else {
                    circularGroupItem.setBackgroundImageNamed("CircularFrame-")
                }
                
                circularGroupItem.startAnimatingWithImages(in: NSMakeRange(lastBatteryLevel, level+1), duration: duration, repeatCount: 1)
            } else {
                if lowPowerModeActive {
                    batteryGroupItem.setBackgroundImageNamed("BatteryLowPowerFrame-")
                } else {
                    batteryGroupItem.setBackgroundImageNamed("BatteryFrame-")
                }
                
                batteryGroupItem.startAnimatingWithImages(in: NSMakeRange(lastBatteryLevel, level+1), duration: duration, repeatCount: 1)
            }
        } else if lowPowerModeActive {
            // If low power mode is active, but battery level hasn't changed since the last update
            batteryGroupItem.setBackgroundImageNamed("BatteryLowPowerFrame-\(level)")
            circularGroupItem.setBackgroundImageNamed("CircularLowPowerFrame-\(level)")
        } else {
            batteryGroupItem.setBackgroundImageNamed("BatteryFrame-\(level)")
            circularGroupItem.setBackgroundImageNamed("CircularFrame-\(level)")
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
