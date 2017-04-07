//
//  TableFooterView.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 08/03/2017.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class TableFooterView: UIView {
    
    var textLabel = UILabel()

    convenience init(_ text: String) {
        self.init()
        
        textLabel.text = text
        setupViews()
    }
    
    func setupViews() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = UIFont.systemFont(ofSize: 12)
        textLabel.numberOfLines = 0;
        textLabel.textColor = UIColor(red:0.43, green:0.43, blue:0.45, alpha:1.00)
        addSubview(textLabel)
        
        addConstraint(NSLayoutConstraint(item: textLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 5))
        
        addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1.0, constant: -35))
    }

}
