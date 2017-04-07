//
//  AppearanceTableViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 04.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class AppearanceTableViewController: UITableViewController {

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
            return 130
        }
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Homescreen Icon"
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
                
                let homescreenImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 130))
                homescreenImageView.image = UIImage(named: "HSB1")
                homescreenImageView.contentMode = .scaleToFill
                cell?.contentView.addSubview(homescreenImageView)
                
                let effect = UIBlurEffect(style: .dark)
                let visualEffectView = UIVisualEffectView(effect: effect)
                visualEffectView.frame = homescreenImageView.bounds
                homescreenImageView.addSubview(visualEffectView)
                
                
                let iconImageView = UIImageView(image: UIImage(named: "CircularW"))
                iconImageView.heightAnchor.constraint(equalToConstant: 65).isActive = true
                iconImageView.widthAnchor.constraint(equalToConstant: 65).isActive = true
                
                
                let iconImageView2 = UIImageView(image: UIImage(named: "CircularE"))
                iconImageView2.heightAnchor.constraint(equalToConstant: 65).isActive = true
                iconImageView2.widthAnchor.constraint(equalToConstant: 65).isActive = true

                let iconImageView3 = UIImageView(image: UIImage(named: "CircularB"))
                iconImageView3.heightAnchor.constraint(equalToConstant: 65).isActive = true
                iconImageView3.widthAnchor.constraint(equalToConstant: 65).isActive = true
                
                let iconImageView4 = UIImageView(image: UIImage(named: "CircularI"))
                iconImageView4.heightAnchor.constraint(equalToConstant: 65).isActive = true
                iconImageView4.widthAnchor.constraint(equalToConstant: 65).isActive = true
                
                
                let stackView = UIStackView(frame: cell!.bounds)
                stackView.alignment = .center
                stackView.axis = .horizontal
                stackView.distribution = .equalSpacing
                stackView.spacing = 30
                
                stackView.addArrangedSubview(iconImageView)
                stackView.addArrangedSubview(iconImageView2)
                stackView.addArrangedSubview(iconImageView3)
                stackView.addArrangedSubview(iconImageView4)
                
                cell?.contentView.addSubview(stackView)
                
                
                /*
                
                homescreenImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: homescreenImageView, attribute: .centerY, multiplier: 1.0, constant: 0))
                
                homescreenImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 65))
                
                homescreenImageView.addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 65))*/
            }
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
