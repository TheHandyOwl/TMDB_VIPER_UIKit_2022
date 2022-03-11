//
//  MovieDetailWireFrame.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation
import UIKit


// MARK: protocol MovieDetailWireFrameProtocol
protocol MovieDetailWireFrameProtocol: AnyObject {
    // PRESENTER -> WIREFRAME
    static func createMovieDetailModule(movieId: String) -> UIViewController
}


// MARK: MovieDetailWireFrame
class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    
    private static var mainView: UIViewController {
        return MovieDetailView(nibName: Constants.Views.MovieDetail.nibName, bundle: Bundle.main)
    }
    
    class func createMovieDetailModule(movieId: String) -> UIViewController {

        if let view = mainView as? MovieDetailView {
            let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter()
            let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor()
            let localDataManager: MovieDetailLocalDataManagerInputProtocol = MovieDetailLocalDataManager()
            let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager()
            let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            //remoteDataManager.remoteRequestHandler = interactor
            
            presenter.movieId = movieId
            
            return view
        }
        
        return UIViewController()
    }
    
}
