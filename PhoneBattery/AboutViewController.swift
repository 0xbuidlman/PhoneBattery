//
//  AboutViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voss on 21.06.15.
//  Copyright (c) 2015 Marcel Voss. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init!(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("ABOUT", comment: "")
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: "sharePressed:")
        
        var headerView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 160))
        let backgroundImageView = UIImageView(image: UIImage(named: "BackgroundImage"))
        backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 130)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFit
        headerView.addSubview(backgroundImageView)
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(visualEffectView)
        
        let appIconImageView = UIImageView(image: UIImage(named: "MaskedIcon"))
        appIconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        appIconImageView.contentMode = UIViewContentMode.ScaleAspectFit
        visualEffectView.addSubview(appIconImageView)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Right, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterX, multiplier: 1.0, constant: -20))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 130 / 2))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: appIconImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 130 / 2))
        
        
        let nameLabel = UILabel()
        nameLabel.text = "PhoneBattery"
        nameLabel.font = UIFont.boldSystemFontOfSize(17)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(nameLabel)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: visualEffectView, attribute: .CenterY, multiplier: 1.0, constant: -7))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Left, relatedBy: .Equal, toItem: appIconImageView, attribute: .Right, multiplier: 1.0, constant: 20))
        
        
        let shortString = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        let buildString = NSBundle.mainBundle().infoDictionary!["CFBundleVersion"] as! String
        
        let versionLabel = UILabel()
        versionLabel.text = String(format: "Version %@ (%@)", shortString, buildString)
        versionLabel.font = UIFont.systemFontOfSize(13)
        versionLabel.textColor = UIColor.whiteColor()
        versionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        visualEffectView.addSubview(versionLabel)
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .Top, relatedBy: .Equal, toItem: nameLabel, attribute: .Bottom, multiplier: 1.0, constant: 0))
        
        visualEffectView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .Left, relatedBy: .Equal, toItem: nameLabel, attribute: .Left, multiplier: 1.0, constant: 0))
        
        
        
        self.tableView.tableHeaderView = headerView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sharePressed(barButton: UIBarButtonItem) {
        let activityVC = UIActivityViewController(activityItems: ["PhoneBattery is a simple way to check your phone's battery on your Apple Watch!", NSURL(string: "https://itunes.apple.com/us/app/phonebattery-your-phones-battery/id1009278300?ls=1&mt=8")!], applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return NSLocalizedString("WHO_MADE_THIS", comment: "").uppercaseString
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 2 {
            return NSLocalizedString("THANKS_DOWNLOADING", comment: "")
        }
        return ""
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                return 75
            }
        }
        return 44
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cellIdentifier") as! UITableViewCell?
        var cell2 = tableView.dequeueReusableCellWithIdentifier("cellidentifier2") as! CreatorTableViewCell?
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier")
            cell2 = CreatorTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cellIdentifier2")
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = NSLocalizedString("RATE_ON_STORE", comment: "")
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell2?.nameLabel.text = "Marcel Voss"
                cell2?.jobLabel.text = "Code & Design"
                cell2?.avatarImageView.image = UIImage(named: "MarcelAvatar")
                return cell2!
            }
        } else if indexPath.section == 2 {
            
        }

        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                UIApplication.sharedApplication().openURL(NSURL(string: "http://twitter.com/uimarcel")!)
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

}