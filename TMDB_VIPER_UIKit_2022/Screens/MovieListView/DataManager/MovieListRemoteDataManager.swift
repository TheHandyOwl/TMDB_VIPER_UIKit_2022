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


// MARK: - MovieListRemoteDataManagerInputProtocol
final class MovieListRemoteDataManager: MovieListRemoteDataManagerInputProtocol {
    
    //var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol?
    
    private var firstPage = Constants.API.moviesFirstPage
    private var incrementPage = Constants.API.moviesIncrementPage
    private var limitPage = Constants.API.moviesPageLimit
    private var page = Constants.API.moviesInitialPage
    private var reachedPageLimit = false
    
    func getPopularMovies(success: @escaping (([MovieResponse]) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        
        page = (page != Constants.API.moviesInitialPage) ?  page + incrementPage : firstPage
        
        if reachedPageLimit == true {
            failure(.noRequest)
            return
        }
        
        if page > limitPage {
            reachedPageLimit = true
            failure(.pageLimitReached)
            return
        }
        
        let urlString = "\(Constants.API.URL.urlMainSite)\(Constants.API.Endpoints.urlEndpointListMovies)\(Constants.API.apiKeyParam)\(Constants.API.apiKeyValue)\(Constants.API.Params.paramPage)\(page)"
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
