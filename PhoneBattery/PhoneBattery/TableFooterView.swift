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
        
    }

}
