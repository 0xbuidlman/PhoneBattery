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
import SafariServices
import UserNotifications

class MainTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let notificationSwitch = UISwitch()
    var visualEffectView: UIVisualEffectView?
    let settings = SettingsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("WELCOME", comment: "")
        
        navigationController?.navigationBar.tintColor = .phoneBatteryGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        notificationSwitch.setOn(settings.useStatusNotifications, animated: false)
        notificationSwitch.onTintColor = .phoneBatteryGreen
        notificationSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        
        setupViewHierachy()
    }
    
    func switchValueChanged(sender: UISwitch) {
        if sender == notificationSwitch {
            settings.useStatusNotifications = sender.isOn
            
            // Ask for notification authorization
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
                // TODO: Add error handling
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
    
    func setupViewHierachy() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 140))
        
        let imageView = UIImageView(frame: headerView.bounds)
        imageView.image = UIImage(named: "HeaderImage")
        headerView.addSubview(imageView)
        
        let effect = UIBlurEffect(style: .dark)
        visualEffectView = UIVisualEffectView(effect: effect)
        visualEffectView?.frame = headerView.bounds
        imageView.addSubview(visualEffectView!)
        
        tableView.tableHeaderView = headerView
        
        
        let iconImageView = UIImageView(image: UIImage(named: "CircularW"))
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        headerView.addSubview(iconImageView)
        
        headerView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        headerView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .right, relatedBy: .equal, toItem: headerView, attribute: .centerX, multiplier: 1.0, constant: -20))
        
        headerView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 75))
        
        headerView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 75))
        
        
        let nameLabel = UILabel()
        nameLabel.text = "PhoneBattery"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = .white
        headerView.addSubview(nameLabel)
        
        headerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: headerView, attribute: .centerY, multiplier: 1.0, constant: -7))
        
        headerView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .left, relatedBy: .equal, toItem: iconImageView, attribute: .right, multiplier: 1.0, constant: 20))
        
        
        let versionLabel = UILabel()
        versionLabel.text = "Version \(DeviceInformation.versionNumber) (\(DeviceInformation.buildNumber))"
        versionLabel.font = UIFont.systemFont(ofSize: 13)
        versionLabel.textColor = .white
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(versionLabel)
        
        headerView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        headerView.addConstraint(NSLayoutConstraint(item: versionLabel, attribute: .left, relatedBy: .equal, toItem: nameLabel, attribute: .left, multiplier: 1.0, constant: 0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sharePressed() {
        if let phoneBatteryAppStoreURL = URL(string: "https://itunes.apple.com/de/app/phonebattery-your-phones-battery-on-your-wrist/id1009278300?l=en&mt=8") {
            
            let shareText = NSLocalizedString("PHONEBATTERY_SHARE", comment: "")
            
            let activityVC = UIActivityViewController(activityItems: [shareText, phoneBatteryAppStoreURL], applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 2 {
            let footer = TableFooterView(NSLocalizedString("THANKS", comment: ""))
            footer.textLabel.textAlignment = .center
            return footer
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("NOTIFICATIONS_DESCRIPTION", comment: "")
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("SETTINGS", comment: "")
        } else if section == 1 {
            return NSLocalizedString("ABOUT", comment: "")
        } else if section == 2 {
            return NSLocalizedString("MORE", comment: "")
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return tableView.sectionFooterHeight
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 3
        } else if section == 2 {
            return 2
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = NSLocalizedString("APPEARANCE", comment: "")
            } else if indexPath.row == 1 {
                cell.selectionStyle = .none
                cell.textLabel?.text = NSLocalizedString("BATTERY_NOTIFICATIONS", comment: "")
                cell.accessoryView = notificationSwitch
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("HELP", comment: "")
                cell.accessoryType = .disclosureIndicator
            } else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("INTRODUCTION", comment: "")
                cell.accessoryType = .disclosureIndicator
            } else if indexPath.row == 2 {
                cell.textLabel?.text = NSLocalizedString("RATE_APP_STORE", comment: "")
                cell.accessoryType = .disclosureIndicator
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel?.text = NSLocalizedString("GITHUB", comment: "")
                cell.accessoryType = .disclosureIndicator
            } else if indexPath.row == 1 {
                cell.textLabel?.text = NSLocalizedString("TWITTER", comment: "")
                cell.accessoryType = .disclosureIndicator
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let appearanceVC = AppearanceTableViewController(style: .grouped)
                navigationController?.pushViewController(appearanceVC, animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("FAQ", comment: ""), style: .default, handler: { (action) in
                    if let faqURL = URL(string: "http://marcelvoss.com/phonebattery/faq") {
                        let safariVC = SFSafariViewController(url: faqURL, entersReaderIfAvailable: false)
                        self.present(safariVC, animated: true, completion: nil)
                    }
                }))
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("SUPPORT", comment: ""), style: .default, handler: { (action) in
                    if MFMailComposeViewController.canSendMail() {
                        self.setupSupportViewController()
                    } else {
                        if let supportURL = URL(string: "http://marcelvoss.com/phonebattery") {
                            let safariVC = SFSafariViewController(url: supportURL, entersReaderIfAvailable: false)
                            self.present(safariVC, animated: true, completion: nil)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL", comment: ""), style: .cancel, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            } else if indexPath.row == 1 {
                // TODO: Add introduction
                
                
                
                
            } else if indexPath.row == 2 {
                if #available(iOS 10.3, *) {
                    SKStoreReviewController.requestReview()
                } else {
                    if let storeURL = URL(string: "https://itunes.apple.com/de/app/phonebattery-your-phones-battery-on-your-wrist/id1009278300?l=en&mt=8") {
                        UIApplication.shared.open(storeURL, options: [:], completionHandler: nil)
                    }
                }
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                if let repoURL = URL(string: "https://github.com/marcelvoss/PhoneBattery") {
                    let safariVC = SFSafariViewController(url: repoURL, entersReaderIfAvailable: false)
                    self.present(safariVC, animated: true, completion: nil)
                }
            } else if indexPath.row == 1 {
                
                // TODO: Fix this horrible mess
                
                let follow = Follow()
                let twitterHandle = "phonebatteryapp"
                follow.accounts { (accounts, granted, error) in
                    if let twitterAccounts = accounts {
                        if error == nil && granted, let actionSheet = follow.actionSheet(accounts: accounts, username: twitterHandle) {
                            
                            DispatchQueue.main.sync {
                                self.present(actionSheet, animated: true, completion: nil)
                            }
                        } else if !granted || twitterAccounts.count == 0 {
                            _ = follow.showProfile(username: twitterHandle)
                        }
                    } else {
                        _ = follow.showProfile(username: twitterHandle)
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
        
        // Convert boolean to string
        var watchAppInstalledString = "n/a"
        if let theSession  = WatchManager.sharedInstance.session {
             watchAppInstalledString = theSession.isWatchAppInstalled ? "Yes" : "No"
        }
        
        composeViewController.setMessageBody("\n\n\n------\niOS Version: \(UIDevice.current.systemVersion)\nHardware Identifier: \(DeviceInformation.hardwareIdentifier)\nWatch App Installed: \(watchAppInstalledString)", isHTML: false)
        
        present(composeViewController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}
