//
//  MovieDetailInteractor.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation


// MARK: - protocol MovieDetailInteractorInputProtocol
protocol MovieDetailInteractorInputProtocol: AnyObject {
    // PRESENTER -> INTERACTOR
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var localDatamanager: MovieDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }
    
    func addOrRemoveFavorite(state: Bool, movieDetail: MovieDetail, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ()))
    func getMovie(movieID: Int, success: @escaping ((MovieDetail) -> ()), failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: - protocol MovieDetailRemoteDataManagerOutputProtocol
protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}


// MARK: - MovieDetailInteractor
final class MovieDetailInteractor {

    // MARK: Properties
    weak var presenter: MovieDetailInteractorOutputProtocol?
    var localDatamanager: MovieDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
    
    private func mapMovieDetailResponseToMovieDetail(movieDetailResponse: MovieDetailResponse) -> MovieDetail {
        let movieDetail = MovieDetail(
            movieID: movieDetailResponse.id,
            image: movieDetailResponse.posterPath,
            originalTitle: movieDetailResponse.originalTitle,
            rating: String(movieDetailResponse.voteAverage),
            releaseDate: movieDetailResponse.releaseDate,
            synopsis: movieDetailResponse.synopsis,
            title: movieDetailResponse.title,
            favorite: false)
        return movieDetail
    }
    
    private func mapMovieWithFavoriteTag(movieNotTagged: MovieDetail) -> MovieDetail {
        guard let localDatamanager = localDatamanager else {
            return movieNotTagged
        }
        
        if localDatamanager.existsMovie(movieID: movieNotTagged.movieID) {
            let movieTagged = MovieDetail(movieID: movieNotTagged.movieID, image: movieNotTagged.image, originalTitle: movieNotTagged.originalTitle, rating: movieNotTagged.rating, releaseDate: movieNotTagged.releaseDate, synopsis: movieNotTagged.synopsis, title: movieNotTagged.title, favorite: true)
            return movieTagged
        }
        
        return movieNotTagged
    }
    
}


// MARK: - MovieDetailInteractorInputProtocol
extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    
    func addOrRemoveFavorite(state: Bool, movieDetail: MovieDetail, success: @escaping (() -> ()), failure: @escaping ((CoreDataErrors) -> ())) {
        localDatamanager?.addOrRemoveFavorite(state: state, movieDetail: movieDetail, success: success, failure: failure)
    }
    
    func getMovie(movieID: Int, success: @escaping ((MovieDetail) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        remoteDatamanager?.getMovie(movieID: movieID, success: { [weak self] movieDetailResponse in
            if let movieWithoutFavoriteTag = self?.mapMovieDetailResponseToMovieDetail(movieDetailResponse: movieDetailResponse) {
                if let movieWithFavoriteTag = self?.mapMovieWithFavoriteTag(movieNotTagged: movieWithoutFavoriteTag) {
                    success(movieWithFavoriteTag)
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


// MARK: - MovieDetailRemoteDataManagerOutputProtocol
extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
}
