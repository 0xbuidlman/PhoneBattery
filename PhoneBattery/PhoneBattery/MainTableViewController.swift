//
//  MainTableViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 08/03/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class MainTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let notificationSwitch = UISwitch()
    var visualEffectView: UIVisualEffectView?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PhoneBattery"
        
        navigationController?.navigationBar.tintColor = .phoneBatteryGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        notificationSwitch.setOn(true, animated: false)
        notificationSwitch.onTintColor = .phoneBatteryGreen
        
        setupViewHierachy()
    }
    
    func setupViewHierachy() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        
        let imageView = UIImageView(frame: headerView.bounds)
        imageView.image = UIImage(named: "HeaderImage")
        headerView.addSubview(imageView)
        
        let effect = UIBlurEffect(style: .regular)
        visualEffectView = UIVisualEffectView(effect: effect)
        visualEffectView?.frame = headerView.bounds
        imageView.addSubview(visualEffectView!)
        
        tableView.tableHeaderView = headerView
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
            let footer = TableFooterView("Thanks for using PhoneBattery! <3")
            footer.textLabel.textAlignment = .center
            return footer
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Settings"
        } else if section == 1 {
            return "About"
        } else if section == 2 {
            return "More"
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 35
        }
        return tableView.sectionFooterHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 3
        } else if section == 2 {
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
                cell.accessoryType = .disclosureIndicator
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "Introduction"
                cell.accessoryType = .disclosureIndicator
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "Rate on the App Store"
                cell.accessoryType = .disclosureIndicator
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Code on GitHub"
                cell.accessoryType = .disclosureIndicator
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 0 {
                
                if MFMailComposeViewController.canSendMail() {
                    setupSupportViewController()
                } else {
                    if let supportURL = URL(string: "http://marcelvoss.com") {
                        UIApplication.shared.open(supportURL, options: [:], completionHandler: nil)
                    }
                }
                
            } else if indexPath.row == 1 {
                
            } else if indexPath.row == 2 {
                if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                } else {
                    if let storeURL = URL(string: "https://itunes.apple.com/de/app/phonebattery-your-phones-battery-on-your-wrist/id1009278300?l=en&mt=8") {
                        UIApplication.shared.open(storeURL, options: [:], completionHandler: nil)
                    }
                }
            }
        }
    }
    
    func setupSupportViewController() {
        let composeViewController = MFMailComposeViewController()
        composeViewController.mailComposeDelegate = self
        
        composeViewController.setToRecipients(["me@marcelvoss.com"])
        composeViewController.setSubject("PhoneBattery \(DeviceInformation.versionNumber) (\(DeviceInformation.buildNumber))")
        
        composeViewController.setMessageBody("\n\n\n------\niOS Version: \(UIDevice.current.systemVersion)", isHTML: false)
        
        present(composeViewController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
