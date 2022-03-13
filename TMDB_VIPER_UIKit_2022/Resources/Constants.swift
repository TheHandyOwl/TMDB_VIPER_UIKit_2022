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
        static let moviesInitialPage = -1
        static let moviesFirstPage = 1
        static let moviesIncrementPage = 1
        static let moviesPageLimit = 500
        
        struct URL {
            static let urlMainSite = "https://api.themoviedb.org/"
            static let urlMainImagesW200 = "https://image.tmdb.org/t/p/w200/"
        }
        
        struct Endpoints {
            static let urlEndpointListMovies = "3/movie/popular"
            static let urlEndpointDetailMovie = "3/movie/"
        }
        
        struct Params {
            static let paramPage = "&page="
        }
        
    }
    
    
    // MARK: Managers
    struct Managers {
        
        struct CoreData {
            static let favoriteMovieEntityName = "CDFavorite"
            static let favoritesPersistentContainer = "MoviesCoreData"
        }
        
    }
    
    
    // MARK: Strings
    struct Strings {
        static let addFavoriteLiteral = "Add favorite"
        static let deleteLiteral = "Delete"
        static let errorLiteral = "Error"
        static let removeFavoriteLiteral = "Remove favorite"
    }
    
    
    // MARK: Views
    struct Views {
        
        struct Favorites {
            static let nibName = "FavoritesView"
            static let title = "Favorites"
        }
        
        struct Home {
            static let firstTabBarIcon = "film"
            static let firstTabBarText = "Movies"
            static let secondTabBarIcon = "star"
            static let secondTabBarText = "Favorites"
        }
        
        struct MovieList {
            
            static let nibName = "MovieListView"
            static let searchBarPlaceholder = "Search movie title here..."
            static let title = "Movies"
            
            struct MovieCell {
                static let cellID = "MovieListCellViewID"
                static let nibName = "MovieListCellView"
                static let placeholderImage = "film.circle"
            }
            
        }
        
        struct MovieDetail {
            static let mockID = "634649"
            static let nibName = "MovieDetailView"
            static let placeholderImage = "film.circle"
            static let title = "Movie detail"
        }
        
    }
    
}
