//
//  AppearanceTableViewController.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 04.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class AppearanceTableViewController: UITableViewController {
    
    let previewScrollView = UIScrollView()
    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Appearance"
        
        
        previewScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150)
        previewScrollView.isPagingEnabled = true
        previewScrollView.delegate = self
        previewScrollView.showsHorizontalScrollIndicator = false
        
        let numberOfPages = 2
        previewScrollView.contentSize = CGSize(width: tableView.frame.size.width * CGFloat(numberOfPages), height: 150)
        pageControl.numberOfPages = numberOfPages
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
            return "Preview"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            footerView.addSubview(pageControl)
            
            footerView.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .centerX, relatedBy: .equal, toItem: footerView, attribute: .centerX, multiplier: 1.0, constant: 0))
            
            footerView.addConstraint(NSLayoutConstraint(item: pageControl, attribute: .centerY, relatedBy: .equal, toItem: footerView, attribute: .centerY, multiplier: 1.0, constant: 0))
            
            return footerView
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
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
                
                previewScrollView.backgroundColor = .red
                
                cell?.contentView.addSubview(previewScrollView)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell?.textLabel?.text = "Radial"
            } else if indexPath.row == 1 {
                cell?.textLabel?.text = "Square"
            }
        }

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === previewScrollView {
            let pageWidth = scrollView.frame.size.width
            let offset = scrollView.contentOffset.x / pageWidth
            let page = lround(Double(offset))
            pageControl.currentPage = page
        }
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
