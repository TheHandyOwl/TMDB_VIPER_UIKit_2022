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
    
    func getMovie(movieID: Int, success: @escaping ((MovieDetail) -> ()), failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: - protocol MovieDetailRemoteDataManagerOutputProtocol
protocol MovieDetailRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}


// MARK: - MovieDetailInteractorInputProtocol
final class MovieDetailInteractor: MovieDetailInteractorInputProtocol {

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
            title: movieDetailResponse.title)
        return movieDetail
    }
    
    func getMovie(movieID: Int, success: @escaping ((MovieDetail) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        remoteDatamanager?.getMovie(movieID: movieID, success: { [weak self] movieDetailResponse in
            if let movieDetail = self?.mapMovieDetailResponseToMovieDetail(movieDetailResponse: movieDetailResponse) {
                success(movieDetail)
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
