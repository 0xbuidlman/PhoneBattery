//
//  AppDelegate.swift
//  PhoneBattery
//
//  Created by Marcel Voss on 19.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        
        // [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: .Alert, categories: .None))
        
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.boolForKey("hasRunBefore") == false {
            
            // Array with Integers for the notfication settings
            let activeNotifications = [0, 1]
            defaults.setObject(activeNotifications, forKey: "activeNotfications")
            
            defaults.setBool(true, forKey: "hasRunBefore")
            defaults.synchronize()
            
        }
        
        let navController = UINavigationController(rootViewController: AboutViewController(style: UITableViewStyle.Grouped))
        self.window?.rootViewController = navController
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        
        // TODO: Doesn't work
        let batteryObject = BatteryInformation().concludedInformation()
        let level = String(batteryObject.batteryLevel) + "%"
        
        
        let localNotification = UILocalNotification()
        localNotification.fireDate = NSDate()
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertBody = String(format: "Your battery level is at %@%%.", level)
        localNotification.alertAction = "OK"
        application.scheduleLocalNotification(localNotification)
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

