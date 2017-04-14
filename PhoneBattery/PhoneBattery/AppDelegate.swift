//
//  AppDelegate.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 21/02/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let settings = SettingsModel()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        
        Fabric.with([Crashlytics.self])
        
        #if arch(i386) || arch(x86_64)
            print("Notice: PhoneBattery is running in iOS simulator and will show wrong values since battery simulation isn't available. To see real values (such as battery level and battery state, run it on a real device.")
        #endif

        // TODO: Handle possible errors
        _ = WatchManager.sharedInstance.setup()
        
        let navController = UINavigationController(rootViewController: MainTableViewController(style: .grouped))
        self.window?.rootViewController = navController
        
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
        return true
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("AppDelegate received fetch request")
        
        if settings.useStatusNotifications {
            let batteryObject = BatteryInformation()
            
            var stateString = "."
            if batteryObject.batteryState == 2 {
                stateString = " and is charging."
            } else if batteryObject.batteryState == 3 {
                stateString = " and has completed charging."
            }
            
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("NOTIFICATION_TITLE", comment: "")
            content.body = "Your phone's battery level is at \(batteryObject.batteryLevel)%\(stateString)"
            
            let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
            let request = UNNotificationRequest(identifier: "com.marcelvoss.PhoneBattery.NotifiationRequest", content: content, trigger: timeTrigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    // Do something with error
                    print("Error while scheduling battery notification: \(error.localizedDescription)")
                    completionHandler(.failed)
                } else {
                    // Request was added successfully
                    print("Scheduled battery notification")
                    completionHandler(.newData)
                }
            }
        }
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

