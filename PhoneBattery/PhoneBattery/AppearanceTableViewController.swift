//
//  AppearanceTableViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 04.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit
import WatchConnectivity

class AppearanceTableViewController: UITableViewController, WCSessionDelegate {
    
    let circularInterfaceSwitch = UISwitch()
    let settings = SettingsModel()
    let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("APPEARANCE", comment: "")
        
        if WCSession.isSupported() {
            session?.delegate = self
            session?.activate()
        }
        
        circularInterfaceSwitch.onTintColor = .phoneBatteryGreen
        circularInterfaceSwitch.setOn(settings.useCircularIndicator, animated: false)
        circularInterfaceSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        
        let headerView = PreviewWatchView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 240))
        tableView.tableHeaderView = headerView
    }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")

        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = NSLocalizedString("CIRCULAR_INDICATOR", comment: "")
                cell?.selectionStyle = .none
                cell?.accessoryView = circularInterfaceSwitch
            }
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
