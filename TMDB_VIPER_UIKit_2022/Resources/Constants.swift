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
        static let addFavoriteLiteral = NSLocalizedString("Strings_AddFavoriteLiteral", comment: "Add favorite")
        static let deleteLiteral = NSLocalizedString("Strings_DeleteLiteral", comment: "Delete")
        static let errorLiteral = NSLocalizedString("Strings_ErrorLiteral", comment: "Error")
        static let removeFavoriteLiteral = NSLocalizedString("Strings_RemoveFavoriteLiteral", comment: "Remove favorite")
    }
    
    
    // MARK: Views
    struct Views {
        
        struct Favorites {
            static let nibName = "FavoritesView"
            static let placeholderImage = "film.circle"
            static let title = NSLocalizedString("Favorites_Title", comment: "Favorites title")
            
            struct FavoritesCell {
                static let cellID = "FavoritesCellViewID"
                static let nibName = "FavoritesCellView"
                static let placeholderImage = "film.circle"
            }
            
        }
        
        struct Home {
            static let firstTabBarIcon = "film"
            static let secondTabBarIcon = "star"

            static let firstTabBarText = NSLocalizedString("Home_FirstButtonTitle", comment: "1st button title")
            static let secondTabBarText = NSLocalizedString("Home_SecondButtonTitle", comment: "2nd button title")
        }
        
        struct MovieList {
            
            static let nibName = "MovieListView"
            static let searchBarPlaceholder = NSLocalizedString("MovieList_searchBarPlaceholder", comment: "searchBarPlaceholder")
            static let title = NSLocalizedString("MovieList_Title", comment: "Title")
            
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
            static let title = NSLocalizedString("MovieDetail_Title", comment: "Movie detail title")
        }
        
    }
    
}
