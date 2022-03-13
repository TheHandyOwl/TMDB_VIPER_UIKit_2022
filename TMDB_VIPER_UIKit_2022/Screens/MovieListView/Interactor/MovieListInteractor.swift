//
//  MovieListInteractor.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation


// MARK: - InteractorInputProtocol
protocol MovieListInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var localDatamanager: MovieListLocalDataManagerInputProtocol? { get set }
    var mockDatamanager: MovieListMockDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
    
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ()))
    func getPopularMovies(success: @escaping (([Movie]) -> ()), failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: - LocalDataManagerOutputProtocol
protocol MovieListLocalDataManagerOutputProtocol: AnyObject {
    // LOCALDATAMANAGER -> INTERACTOR
}


// MARK: - MockDataManagerOutputProtocol
protocol MovieListMockDataManagerOutputProtocol: AnyObject {
    // MOCKDATAMANAGER -> INTERACTOR
}


// MARK: - RemoteDataManagerOutputProtocol
protocol MovieListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}


// MARK: - MovieListInteractor
final class MovieListInteractor {

    // MARK: Properties
    weak var presenter: MovieListInteractorOutputProtocol?
    var localDatamanager: MovieListLocalDataManagerInputProtocol?
    var mockDatamanager: MovieListMockDataManagerInputProtocol?
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol?
    
    private func mapMoviesResponseToMovies(moviesResponse: [MovieResponse]) -> [Movie] {
        let movies = moviesResponse.map {
            Movie(movieID: $0.id, title: $0.title, synopsis: $0.synopsis, image: $0.posterPath)
        }
        return movies
    }
    
    private func mapMoviesWithFavoriteTag(moviesNotTagged: [Movie]) -> [Movie] {
        guard let favoriteMovies = localDatamanager?.getFavoriteMovies() else {
            return moviesNotTagged
        }
        
        let moviesTagged = moviesNotTagged.map { movie -> Movie in
            let favorite = favoriteMovies.filter { $0.movieID == movie.movieID }.count > 0 ? true : false

            if favorite {
                let newMovie = Movie(movieID: movie.movieID, title: movie.title, synopsis: movie.synopsis, image: movie.image, favorite: favorite)
                return newMovie
            }
            
            return movie
        }
        
        return moviesTagged
    }
    
}


// MARK: - MovieListInteractorInputProtocol
extension MovieListInteractor: MovieListInteractorInputProtocol {
    
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        localDatamanager?.addOrRemoveFavorite(movie: movie, success: success, failure: failure)
    }
    
    func getPopularMovies(success: @escaping (([Movie]) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        //mockDatamanager?.getPopularMovies(success: success, failure: failure)
        remoteDatamanager?.getPopularMovies(success: { [weak self] moviesResponse in
            if let moviesWithoutFavoriteTag = self?.mapMoviesResponseToMovies(moviesResponse: moviesResponse) {
                if let moviesWithFavoriteTag = self?.mapMoviesWithFavoriteTag(moviesNotTagged: moviesWithoutFavoriteTag) {
                    success(moviesWithFavoriteTag)
                } else {
                    failure(.mappingError)
                }
            } else {
                failure(.mappingError)
            }
        }, failure: { networkError in
            failure(networkError)
        })
    }
    
}


// MARK: - RemoteDataManagerOutput
extension MovieListInteractor: MovieListLocalDataManagerOutputProtocol {
}


// MARK: - RemoteDataManagerOutput
extension MovieListInteractor: MovieListMockDataManagerOutputProtocol {
}


// MARK: - RemoteDataManagerOutput
extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {
}
