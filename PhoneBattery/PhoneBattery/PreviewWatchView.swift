//
//  PreviewWatchView.swift
//  PhoneBattery
//
//  Created by Marcel Voß on 08.04.17.
//  Copyright © 2017 Marcel Voss. All rights reserved.
//

import UIKit

class PreviewWatchView: UIView {
    
    enum WatchInterface {
        case circular
        case battery
    }
    
    var watchInterface: WatchInterface?
    
    fileprivate let batteryObject = BatteryInformation()
    fileprivate let settings = SettingsModel()
    
    var timer: Timer?
    let timeLabel = UILabel()
    fileprivate let contentView = UIView()
    fileprivate let batteryStatusLabel = UILabel()
    fileprivate let batteryImageView = UIImageView()
    fileprivate let batteryPercentageLabel = UILabel()
    fileprivate let watchImageView = UIImageView(image: UIImage(named: "WatchSteel"))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewHierarchy()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBatteryInformation),
                                               name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshBatteryInformation),
                                               name: NSNotification.Name.UIDeviceBatteryStateDidChange, object: nil)
        
        
        timer?.fire()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshTime), userInfo: nil, repeats: true)
    }
    
    deinit {
        timer?.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewHierarchy() {
        
        watchImageView.translatesAutoresizingMaskIntoConstraints = false
        watchImageView.contentMode = .scaleAspectFit
        addSubview(watchImageView)
        
        addConstraint(NSLayoutConstraint(item: watchImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: watchImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: watchImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1.0, constant: -40))
        
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .black
        watchImageView.addSubview(contentView)
        
        watchImageView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: watchImageView, attribute: .centerX, multiplier: 1.0, constant: -4))
        
        watchImageView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: watchImageView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        watchImageView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: watchImageView, attribute: .height, multiplier: 1.0, constant: -45))
        
        watchImageView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 105))
        
        
        let appLabel = UILabel()
        appLabel.text = "PhoneBattery"
        appLabel.textColor = .phoneBatteryGreen
        appLabel.translatesAutoresizingMaskIntoConstraints = false
        appLabel.font = UIFont.boldSystemFont(ofSize: 10)
        contentView.addSubview(appLabel)
        
        contentView.addConstraint(NSLayoutConstraint(item: appLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1.0, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: appLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0))
        
        
        timeLabel.textColor = .white
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        timeLabel.textAlignment = .right
        contentView.addSubview(timeLabel)
        
        contentView.addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1.0, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: timeLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1.0, constant: 0))
        
        
        
        let proxyView = UIView()
        proxyView.translatesAutoresizingMaskIntoConstraints = false
        proxyView.backgroundColor = .black
        contentView.addSubview(proxyView)
        
        contentView.addConstraint(NSLayoutConstraint(item: proxyView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: proxyView, attribute: .top, relatedBy: .equal, toItem: appLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: proxyView, attribute: .height, relatedBy: .equal, toItem: contentView, attribute: .height, multiplier: 1.0, constant: -10))
        
        contentView.addConstraint(NSLayoutConstraint(item: proxyView, attribute: .width, relatedBy: .equal, toItem: contentView, attribute: .width, multiplier: 1.0, constant: 0))
  
        
        
        batteryImageView.translatesAutoresizingMaskIntoConstraints = false
        batteryImageView.contentMode = .scaleAspectFit
        proxyView.addSubview(batteryImageView)
        
        addConstraint(NSLayoutConstraint(item: batteryImageView, attribute: .centerX, relatedBy: .equal, toItem: proxyView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: batteryImageView, attribute: .centerY, relatedBy: .equal, toItem: proxyView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        addConstraint(NSLayoutConstraint(item: batteryImageView, attribute: .width, relatedBy: .equal, toItem: proxyView, attribute: .width, multiplier: 0.9, constant: 0))
        
        
        
        
        batteryPercentageLabel.textColor = .white
        batteryPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        batteryPercentageLabel.font = UIFont.systemFont(ofSize: 10)
        batteryPercentageLabel.textAlignment = .center
        batteryImageView.addSubview(batteryPercentageLabel)
        
        batteryImageView.addConstraint(NSLayoutConstraint(item: batteryPercentageLabel, attribute: .centerX, relatedBy: .equal, toItem: batteryImageView, attribute: .centerX, multiplier: 1.0, constant: 0))
        
        if settings.useCircularIndicator {
            batteryImageView.addConstraint(NSLayoutConstraint(item: batteryPercentageLabel, attribute: .centerY, relatedBy: .equal, toItem: batteryImageView, attribute: .centerY, multiplier: 1.0, constant: -6))
        } else {
            batteryImageView.addConstraint(NSLayoutConstraint(item: batteryPercentageLabel, attribute: .centerY, relatedBy: .equal, toItem: batteryImageView, attribute: .centerY, multiplier: 1.0, constant: 0))
        }
        
        
        batteryStatusLabel.textColor = .white
        batteryStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        batteryStatusLabel.font = UIFont.systemFont(ofSize: 10)
        batteryStatusLabel.textAlignment = .center
        
        if settings.useCircularIndicator {
            batteryImageView.addSubview(batteryStatusLabel)
            
            batteryImageView.addConstraint(NSLayoutConstraint(item: batteryStatusLabel, attribute: .top, relatedBy: .equal, toItem: batteryPercentageLabel, attribute: .bottom, multiplier: 1.0, constant: 0))
            
            batteryImageView.addConstraint(NSLayoutConstraint(item: batteryStatusLabel, attribute: .centerX, relatedBy: .equal, toItem: batteryImageView, attribute: .centerX, multiplier: 1.0, constant: 0))
        } else {
            proxyView.addSubview(batteryStatusLabel)
            
            proxyView.addConstraint(NSLayoutConstraint(item: batteryStatusLabel, attribute: .top, relatedBy: .equal, toItem: batteryImageView, attribute: .bottom, multiplier: 1.0, constant: -1))
            
            proxyView.addConstraint(NSLayoutConstraint(item: batteryStatusLabel, attribute: .centerX, relatedBy: .equal, toItem: proxyView, attribute: .centerX, multiplier: 1.0, constant: 0))
        }
        
        animateWatch()
        refreshTime()
        refreshBatteryInformation()
    }
    
    func refreshTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.timeStyle = .short
        timeLabel.text = dateFormatter.string(from: Date())
    }
    
    func animateWatch() {
        var images = [UIImage]()
        
        for i in 0 ... batteryObject.batteryLevel {
            if let image = settings.useCircularIndicator ? UIImage(named: "CircularFrame-\(i)") : UIImage(named: "BatteryFrame-\(i)") {
                images.append(image)
            }
        }
        
        batteryImageView.image = images.last
        batteryImageView.animationImages = images
        batteryImageView.animationDuration = 1
        batteryImageView.animationRepeatCount = 1
        batteryImageView.startAnimating()
    }
    
    func refreshBatteryInformation() {
        
        batteryPercentageLabel.text = "\(batteryObject.batteryLevel)%"
        
        if settings.useCircularIndicator {
            batteryImageView.image = UIImage(named: "CircularFrame-\(batteryObject.batteryLevel)")
        } else {
            batteryImageView.image = UIImage(named: "BatteryFrame-\(batteryObject.batteryLevel)")
        }
        
        if batteryObject.batteryState == 0 {
            batteryStatusLabel.text = "Unknown"
        } else if batteryObject.batteryState == 1 {
            batteryStatusLabel.text = "Left"
        } else if batteryObject.batteryState == 2 {
            batteryStatusLabel.text = "Charging"
        } else if batteryObject.batteryState == 3 {
            batteryStatusLabel.text = "Full"
        }
    }

}
