//
//  FavoritesViewWireFrame.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation
import UIKit


// MARK: - protocol FavoritesViewWireFrameProtocol
protocol FavoritesViewWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createFavoritesViewModule() -> UIViewController
}


// MARK: - FavoritesViewWireFrameProtocol
final class FavoritesViewWireFrame: FavoritesViewWireFrameProtocol {

    private static var mainView: UIViewController {
        return FavoritesView(nibName: Constants.Views.Favorites.nibName, bundle: Bundle.main)
    }
    
    final class func createFavoritesViewModule() -> UIViewController {

        if let view = mainView as? FavoritesView {
            let presenter: FavoritesViewPresenterProtocol & FavoritesViewInteractorOutputProtocol = FavoritesViewPresenter()
            let interactor: FavoritesViewInteractorInputProtocol & FavoritesViewLocalDataManagerOutputProtocol = FavoritesViewInteractor()
            let localDataManager: FavoritesViewLocalDataManagerInputProtocol = FavoritesViewLocalDataManager()
            let remoteDataManager: FavoritesViewRemoteDataManagerInputProtocol = FavoritesViewRemoteDataManager()
            let wireFrame: FavoritesViewWireFrameProtocol = FavoritesViewWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            
            return view
        }
        
        return UIViewController()
    }
    
}
