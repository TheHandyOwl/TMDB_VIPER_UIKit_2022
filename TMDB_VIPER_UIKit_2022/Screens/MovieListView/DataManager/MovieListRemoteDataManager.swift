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
    
    func getPopularMovies(success: @escaping (([MovieResponse]) -> ()), failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: - protocol MovieListRemoteDataManagerOutputProtocol
protocol MovieListRemoteDataManagerOutputProtocol: AnyObject {
    // REMOTEDATAMANAGER -> INTERACTOR
}


// MARK: - MovieListRemoteDataManagerInputProtocol
class MovieListRemoteDataManager: MovieListRemoteDataManagerInputProtocol {
    
    //var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol?
    
    func getPopularMovies(success: @escaping (([MovieResponse]) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        let urlString = "\(Constants.API.URL.urlMainSite)\(Constants.API.Endpoints.urlEndpointListMovies)\(Constants.API.apiKeyParam)\(Constants.API.apiKeyValue)"
        //print("URL - getPopularMovies: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            failure(.urlError)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        ConnectionManager.shared.getData(urlRequest: urlRequest) { data in
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                let movies = moviesResponse.results
                success(movies)
            } catch {
                failure(.decodingJSONError)
            }
        } failure: { networkError in
            failure(networkError)
        }
    }
    
}
