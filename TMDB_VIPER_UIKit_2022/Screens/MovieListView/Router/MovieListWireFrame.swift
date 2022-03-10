//
//  MovieListWireFrame.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation
import UIKit


// MARK: - protocol MovieListWireFrameProtocol
protocol MovieListWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createMovieListModule() -> UIViewController
}


// MARK: - MovieListWireFrameProtocol
class MovieListWireFrame: MovieListWireFrameProtocol {
    
    private static var mainView: UIViewController {
        return MovieListView(nibName: Constants.Views.MovieList.nibName, bundle: Bundle.main)
    }
    
    class func createMovieListModule() -> UIViewController {
        
        let navController = UINavigationController(rootViewController: mainView)

        if let view = navController.children.first as? MovieListView {
            let presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
            let interactor: MovieListInteractorInputProtocol & MovieListRemoteDataManagerOutputProtocol = MovieListInteractor()
            let localDataManager: MovieListLocalDataManagerInputProtocol = MovieListLocalDataManager()
            let mockDataManager: MovieListMockDataManagerInputProtocol = MovieListMockDataManager()
            let remoteDataManager: MovieListRemoteDataManagerInputProtocol = MovieListRemoteDataManager()
            let wireFrame: MovieListWireFrameProtocol = MovieListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.mockDatamanager = mockDataManager
            interactor.remoteDatamanager = remoteDataManager
            //remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        
        return UIViewController()
    }
    
}
