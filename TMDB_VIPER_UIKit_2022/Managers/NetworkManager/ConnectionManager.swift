//
//  ConnectionManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation


// MARK: - ConnectionManager
final class ConnectionManager {
    
    static var shared: ConnectionManager = {
        let instance = ConnectionManager()
        return instance
    }()
    
    func getData(urlRequest: URLRequest, success: @escaping ((Data) -> ()),failure: @escaping ((NetworkErrors) -> ())) {
        
        let session = URLSession.shared
        session.dataTask(with: urlRequest) { data, response, error in
            
            if data == nil, error != nil {
                failure(.networkError)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                failure(.responseError)
                return
            }
            
            guard let data = data else {
                failure(.dataError)
                return
            }
            
            let statusCode = response.statusCode
            
            switch statusCode {
            case 200:
                success(data)
                break
            case 401:
                failure(.statusCode401UnauthorizedError)
                break
            case 403:
                failure(.statusCode403ForbiddenError)
                break
            case 404:
                failure(.statusCode404NotFoundError)
                break
            default:
                failure(.statusCodeGenericError)
                break
            }
            
            return
            
        }.resume()
        
    }
    
    func getJustAnImage(urlRequest: URLRequest, success: @escaping ((Data) -> ())) {
        URLSession.shared.dataTask(with: urlRequest) { imageData, _, _ in
            guard let imageData = imageData else { return }
            success(imageData)
        }.resume()
    }
    
}
