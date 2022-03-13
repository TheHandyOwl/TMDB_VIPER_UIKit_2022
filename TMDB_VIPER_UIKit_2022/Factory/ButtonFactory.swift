//
//  ButtonFactory.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 13/3/22.
//

import Foundation
import UIKit

// MARK: - ButtonFactory
final class ButtonFactory {
    
    static var shared: ButtonFactory = {
        let instance = ButtonFactory()
        return instance
    }()
    
}


extension ButtonFactory {
    
    func createUIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem, target: Any?, action: Selector?) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: barButtonSystemItem, target: target, action: action)
        return barButtonItem
    }
    
}


extension ButtonFactory {
    
    func createToggleUIBarButtonItem(defaultValue: Bool, tintColor: UIColor, target: Any?, action: Selector?) -> UIBarButtonItem {
        let switchControl = UISwitch(frame: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 30)))
        switchControl.isOn = defaultValue
        switchControl.onTintColor = tintColor
        switchControl.setOn(defaultValue, animated: false)
        if let action = action, let target = target {
            switchControl.addTarget(target, action: action, for: .valueChanged)
        }
        
        let barButtonItem = UIBarButtonItem.init(customView: switchControl)
        return barButtonItem
    }
    
}

