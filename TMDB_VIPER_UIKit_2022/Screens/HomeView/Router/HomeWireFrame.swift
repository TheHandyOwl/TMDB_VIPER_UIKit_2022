//
//  HomeWireFrame.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 12/3/22.
//  
//

import Foundation
import UIKit


// MARK: - procotol HomeWireFrameProtocol
protocol HomeWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createHomeModule() -> UITabBarController
}


// MARK: HomeWireFrameProtocol
final class HomeWireFrame: HomeWireFrameProtocol {
    
    final class func createHomeModule() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        
        let firstView = MovieListWireFrame.createMovieListModule()
        let firstTabBarIcon = UIImage(systemName: Constants.Views.Home.firstTabBarIcon)
        let firstTabBarText = Constants.Views.Home.firstTabBarText
        let firstTabBarItem = UITabBarItem(title: firstTabBarText, image: firstTabBarIcon, tag: 1)
        firstView.tabBarItem = firstTabBarItem
        
        let secondView = FavoritesViewWireFrame.createFavoritesViewModule()
        let secondTabBarIcon = UIImage(systemName: Constants.Views.Home.secondTabBarIcon)
        let secondTabBarText = Constants.Views.Home.secondTabBarText
        secondView.tabBarItem = UITabBarItem(title: secondTabBarText, image: secondTabBarIcon, tag: 2)
        
        tabBarController.viewControllers = [firstView, secondView]
        
        return tabBarController
        
    }
    
}
