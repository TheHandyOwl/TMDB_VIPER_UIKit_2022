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
    
    func getPopularMovies(success: @escaping (([Movie]) -> ()), failure: @escaping ((NetworkErrors) -> ()))
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
    
    private func mapMoviesResponseToMovies(moviesResponse: [MovieResponse]) -> [Movie] {
        let movies = moviesResponse.map {
            Movie(movieID: $0.id, title: $0.title, synopsis: $0.overview, image: $0.posterPath)
        }
        return movies
    }
    
    func getPopularMovies(success: @escaping (([Movie]) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        //mockDatamanager?.getPopularMovies(success: success, failure: failure)
        remoteDatamanager?.getPopularMovies(success: { moviesResponse in
            let movies = self.mapMoviesResponseToMovies(moviesResponse: moviesResponse)
            success(movies)
        }, failure: { networkError in
            failure(networkError)
        })
    }

}


// MARK: - MovieListRemoteDataManagerOutputProtocol
extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {
}
