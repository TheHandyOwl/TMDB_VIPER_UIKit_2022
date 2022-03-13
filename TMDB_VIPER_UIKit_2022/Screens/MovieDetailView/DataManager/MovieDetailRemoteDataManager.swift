//
//  MovieDetailRemoteDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation


//MARK: - protocol MovieDetailRemoteDataManagerInputProtocol
protocol MovieDetailRemoteDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> REMOTEDATAMANAGER
    //var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    
    func getMovie(movieID: Int, success: @escaping ((MovieDetailResponse) -> ()), failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: MovieDetailRemoteDataManagerInputProtocol
class MovieDetailRemoteDataManager:MovieDetailRemoteDataManagerInputProtocol {
    
    //var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?

    func getMovie(movieID: Int, success: @escaping ((MovieDetailResponse) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        
        let urlString = "\(Constants.API.URL.urlMainSite)\(Constants.API.Endpoints.urlEndpointDetailMovie)\(movieID)\(Constants.API.apiKeyParam)\(Constants.API.apiKeyValue)"
        //print("URL - getMovie: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            failure(.urlError)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        ConnectionManager.shared.getData(urlRequest: urlRequest) { data in
            do {
                let decoder = JSONDecoder()
                let movieDetailResponse = try decoder.decode(MovieDetailResponse.self, from: data)
                let movie = movieDetailResponse
                success(movie)
            } catch {
                failure(.decodingJSONError)
            }
        } failure: { networkError in
            failure(networkError)
        }
    }
    
}
