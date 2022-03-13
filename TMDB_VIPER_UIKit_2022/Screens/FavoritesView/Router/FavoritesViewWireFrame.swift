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
    
    /// This is the WireFrame for Favorites screen
    /// - Returns: UIViewController with configured VIPER elements embedded in UINavigationController
    static func createFavoritesViewModule() -> UINavigationController
    
    /// Here you can go to DetailView, that shows details of a movie
    /// - Parameters:
    ///   - view: view protocol to push a new controller
    ///   - movieID: identifier needed in  detail view
    func goToDetailView(view: FavoritesViewProtocol, movieID: Int)
}


// MARK: - FavoritesViewWireFrameProtocol
final class FavoritesViewWireFrame: FavoritesViewWireFrameProtocol {

    private static var mainView: UIViewController {
        return FavoritesView(nibName: Constants.Views.Favorites.nibName, bundle: Bundle.main)
    }
    
    final class func createFavoritesViewModule() -> UINavigationController {

        let navController = UINavigationController(rootViewController: mainView)

        if let view = navController.children.first as? FavoritesView {
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
            
            return navController
        }
        
        return UINavigationController()
    }
    
    func goToDetailView(view: FavoritesViewProtocol, movieID: Int) {
        guard let baseView = view as? UIViewController else { return }
        
        DispatchQueue.main.async {
            let vc = MovieDetailWireFrame.createMovieDetailModule(movieID: movieID)
            baseView.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
