//
//  MovieListInteractor.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation


// MARK: - protocol MovieListInteractorInputProtocol
protocol MovieListInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var localDatamanager: MovieListLocalDataManagerInputProtocol? { get set }
    var mockDatamanager: MovieListMockDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
    
    func getMovies(successHandler: (([Movie]) -> ()), errorHandler: ((String) -> ()))
}


// MARK: - protocol MovieListInteractorOutputProtocol
protocol MovieListInteractorOutputProtocol: AnyObject {
// INTERACTOR -> PRESENTER
}


// MARK: - MovieListInteractorInputProtocol
class MovieListInteractor: MovieListInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MovieListInteractorOutputProtocol?
    var localDatamanager: MovieListLocalDataManagerInputProtocol?
    var mockDatamanager: MovieListMockDataManagerInputProtocol?
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol?

}


// MARK: - MovieListRemoteDataManagerOutputProtocol
extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {

    func getMovies(successHandler: (([Movie]) -> ()), errorHandler: ((String) -> ())) {
        mockDatamanager?.getMovies(successHandler: successHandler, errorHandler: errorHandler)
    }

}
