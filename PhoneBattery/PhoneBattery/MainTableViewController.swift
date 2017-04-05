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
import WatchConnectivity

class MainTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let notificationSwitch = UISwitch()
    var visualEffectView: UIVisualEffectView?
    var session: WCSession?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Welcome"
        
        navigationController?.navigationBar.tintColor = .phoneBatteryGreen
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharePressed))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        notificationSwitch.setOn(true, animated: false)
        notificationSwitch.onTintColor = .phoneBatteryGreen
        
        setupViewHierachy()
        
        if WCSession.isSupported() {
            session = WCSession.default()
            //session?.delegate = self
            session?.activate()
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
            
            let shareText = "Just discovered PhoneBattery – an amazing app for displaying your phone's battery life on your Watch."
            
            let activityVC = UIActivityViewController(activityItems: [shareText, phoneBatteryAppStoreURL], applicationActivities: nil)
            present(activityVC, animated: true, completion: nil)
        }
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
            return 2
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
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = "Appearance"
            } else if indexPath.row == 1 {
                cell.selectionStyle = .none
                cell.textLabel?.text = "Battery Notifications"
                cell.accessoryView = notificationSwitch
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Help"
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
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let appearanceVC = AppearanceTableViewController(style: .grouped)
                navigationController?.pushViewController(appearanceVC, animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                
                let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "FAQ", style: .default, handler: { (action) in
                    // TODO: Add real URL
                    if let faqURL = URL(string: "http://marcelvoss.com") {
                        let safariVC = SFSafariViewController(url: faqURL, entersReaderIfAvailable: false)
                        self.present(safariVC, animated: true, completion: nil)
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Support", style: .default, handler: { (action) in
                    if MFMailComposeViewController.canSendMail() {
                        self.setupSupportViewController()
                    } else {
                        // TODO: Add real URL
                        if let supportURL = URL(string: "http://marcelvoss.com") {
                            let safariVC = SFSafariViewController(url: supportURL, entersReaderIfAvailable: false)
                            self.present(safariVC, animated: true, completion: nil)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
                
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
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                if let repoURL = URL(string: "https://github.com/marcelvoss/PhoneBattery") {
                    let safariVC = SFSafariViewController(url: repoURL, entersReaderIfAvailable: false)
                    self.present(safariVC, animated: true, completion: nil)
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
