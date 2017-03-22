//
//  MainTableViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 08/03/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let notificationSwitch = UISwitch()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PhoneBattery"
        
        // FIXME: Doesn't show up
        
        
        self.navigationController?.navigationBar.tintColor = .phoneBatteryGreen()
        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        notificationSwitch.setOn(true, animated: false)
        notificationSwitch.onTintColor = UIColor.phoneBatteryGreen()
    }
    
    func setupViewHierachy() {
        /*
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 130)];
        UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundImage"]];
        backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, headerView.frame.size.height);
        backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
        [headerView addSubview:backgroundImageView];*/
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 130))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sharePressed() {
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            return TableFooterView("By enabling, you'll occasionally receive notifications regarding your phone's battery state and battery level.")
        } else if section == 2 {
            return TableFooterView("Thanks for using PhoneBattery! <3")
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else if section == 1 {
            return ""
        } else if section == 2 {
            return ""
        }
        return ""
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 1
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.selectionStyle = .none
                cell.textLabel?.text = "Battery Notifications"
                cell.accessoryView = notificationSwitch
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Support"
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Introduction"
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Rate on the App Store"
            }
        } else if indexPath.section == 2 {
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
