//
//  NotificationViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 25/10/15.
//  Copyright © 2015 Marcel Voss. All rights reserved.
//

import UIKit

class NotificationViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("NOTIFICATIONS", comment: "")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "QuestionIcon"), style: .Plain, target: self, action: "questionPressed")
        
    }
    
    func questionPressed() {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 45
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 30))
            
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.text = NSLocalizedString("NOTIFICATION_DESCRIPTION", comment: "")
            descriptionLabel.textAlignment = .Center
            descriptionLabel.font = UIFont.systemFontOfSize(12)
            descriptionLabel.numberOfLines = 0
            descriptionLabel.textColor = UIColor(red:0.49, green:0.49, blue:0.51, alpha:1)
            footerView.addSubview(descriptionLabel)
            
            footerView.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .CenterX, relatedBy: .Equal, toItem: footerView, attribute: .CenterX, multiplier: 1.0, constant: 0))
            
            footerView.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Top, relatedBy: .Equal, toItem: footerView, attribute: .Top, multiplier: 1.0, constant: 5))
            
            footerView.addConstraint(NSLayoutConstraint(item: descriptionLabel, attribute: .Width, relatedBy: .Equal, toItem: footerView, attribute: .Width, multiplier: 1.0, constant: -50))
            
            return footerView
        }
        return nil
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") 
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cellIdentifier")
        }
        
        // FIXME: Terrible
        //let defaults = NSUserDefaults.standardUserDefaults()
        //let activeNotifications = defaults.objectForKey("activeNotfications") as! [Int]
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = "10%"
                
                /*
                if activeNotifications[0] == 0 {
                    cell?.accessoryType = .Checkmark
                }
                */
                
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = "20%"
                
                /*
                if activeNotifications[0] == 0 {
                cell?.accessoryType = .Checkmark
                }
                */
            } else if indexPath.row == 2 {
                cell?.textLabel?.text = "50%"
                
                /*
                if activeNotifications[0] == 0 {
                cell?.accessoryType = .Checkmark
                }
                */
            } else if indexPath.row == 3 {
                cell?.textLabel?.text = "100%"
                
                /*
                if activeNotifications[0] == 0 {
                cell?.accessoryType = .Checkmark
                }
                */
            }
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

}
