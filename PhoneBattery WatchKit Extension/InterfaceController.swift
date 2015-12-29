//
//  InterfaceController.swift
//  PhoneBattery WatchKit Extension
//
//  Created by Marcel Voss on 19.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var session: WCSession!
    
    //var batteryObject : BatteryObject!
    
    @IBOutlet weak var percentageLabel: WKInterfaceLabel!
    @IBOutlet weak var statusLabel: WKInterfaceLabel!
    @IBOutlet weak var groupItem: WKInterfaceGroup!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.

        groupItem.setBackgroundImageNamed("frame-")
        self.addMenuItemWithItemIcon(.Resume, title: "Update", action: "refresh")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // To configure and activate the session
        if WCSession.isSupported() {
            session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        self.setTitle(NSLocalizedString("PhoneBattery", comment: ""))
    }
    
    func refresh() {
        
        session.sendMessage(["needsUpdate": true], replyHandler: { (response) -> Void in
            
            if let theBatteryObject = response["batteryObject"] as? BatteryObject {
                
                self.updateInterface(theBatteryObject)
                
            }
            }, errorHandler: { (error) -> Void in
                print(error)
        })
    }
    
    func updateInterface(batteryObject: BatteryObject) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let batteryLevel = batteryObject.batteryLevel
            let batteryState = batteryObject.batteryState
            self.groupItem.setBackgroundImageNamed("frame-")
            self.groupItem.startAnimatingWithImagesInRange(NSMakeRange(0, Int(batteryLevel)+1), duration: 1, repeatCount: 1)
            
            
            let batteryLevelString = String(batteryLevel) + "%"
            
            self.percentageLabel.setText(batteryLevelString)
            self.statusLabel.setText(self.batteryStateForInt(batteryState))
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func batteryStateForInt(stateInt: Int) -> String {
        if stateInt == 0 {
            return NSLocalizedString("UNKNOWN", comment: "")
        } else if stateInt == 1 {
            return NSLocalizedString("REMAINING", comment: "")
        } else if stateInt == 2 {
            return NSLocalizedString("CHARGING", comment: "")
        }  else if stateInt == 3 {
            return NSLocalizedString("FULL", comment: "")
        }
        return ""
    }
    
    /*
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        
        if let theBatteryObject = message["batteryObject"] as? BatteryObject {
            self.batteryObject = theBatteryObject
            self.updateInterface()
        }
        */
    //}
}
