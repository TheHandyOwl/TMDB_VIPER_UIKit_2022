//
//  MovieListRemoteDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation


// MARK: - protocol MovieListRemoteDataManagerInputProtocol
protocol MovieListRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    //var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol? { get set }
}


// MARK: - protocol MovieListRemoteDataManagerOutputProtocol
protocol MovieListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}


// MARK: - MovieListRemoteDataManagerInputProtocol
class MovieListRemoteDataManager: MovieListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol?
}
