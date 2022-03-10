//
//  Constants.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation

struct Constants {
    
    struct Strings {
        static let errorLiteral = "Error"
    }
    
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
