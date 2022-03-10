//
//  Constants.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation


// MARK: - Constants
struct Constants {
    
    
    // MARK: API
    struct API {
        
        static let apiKeyParam = "?api_key="
        static let apiKeyValue = "d535b316cd84b2899e503444201247c1"
        
        struct URL {
            static let urlMainSite = "https://api.themoviedb.org/"
            static let urlMainImagesW200 = "https://image.tmdb.org/t/p/w200/"
        }
        
        struct Endpoints {
            static let urlEndpointListMovies = "3/movie/popular"
        }
        
    }
    
    // MARK: Strings
    struct Strings {
        static let errorLiteral = "Error"
    }
    
    
    // MARK: Views
    struct Views {
        
        struct MovieList {
            
            static let nibName = "MovieListView"
            static let title = "Movies"
            
            struct MovieCell {
                static let cellID = "MovieListCellViewID"
                static let nibName = "MovieListCellView"
                static let placeholderImage = "film.circle"
            }
            
        }
        
    }
    
}
