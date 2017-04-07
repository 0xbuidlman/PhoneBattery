//
//  AppearanceTableViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 04.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class AppearanceTableViewController: UITableViewController {
    
    let interfaceScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Appearance"
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        }
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Watch Interface"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return ""
        }
        return nil
    }
    
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
                cell?.selectionStyle = .none
                
                let homescreenImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
                homescreenImageView.image = UIImage(named: "HSB1")
                homescreenImageView.contentMode = .scaleToFill
                cell?.contentView.addSubview(homescreenImageView)
                
                
                let effect = UIBlurEffect(style: .dark)
                let visualEffectView = UIVisualEffectView(effect: effect)
                visualEffectView.frame = homescreenImageView.bounds
                homescreenImageView.addSubview(visualEffectView)
                
                
                interfaceScrollView.frame = homescreenImageView.bounds
                
                cell?.contentView.addSubview(interfaceScrollView)
                
                
                
                
            }
        }
            
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
