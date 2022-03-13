//
//  ControllerFactory.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation
import UIKit

final class ControllerFactory {
    
    static var shared: ControllerFactory = {
        let instance = ControllerFactory()
        return instance
    }()
    
    func createUISearchController(placeholderText: String) -> UISearchController {
        let controller = UISearchController(searchResultsController: nil)
        
        controller.hidesNavigationBarDuringPresentation = true
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.sizeToFit()
        //controller.searchBar.barStyle = .black
        //controller.searchBar.backgroundColor = .black
        controller.searchBar.placeholder = placeholderText

        return controller
    }
    
}
