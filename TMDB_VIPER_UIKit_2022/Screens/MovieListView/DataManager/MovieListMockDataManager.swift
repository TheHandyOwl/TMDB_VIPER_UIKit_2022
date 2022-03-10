//
//  MovieListMockDataManager.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//

import Foundation


// MARK: - protocol MovieListMockDataManagerInputProtocol
protocol MovieListMockDataManagerInputProtocol: AnyObject {
    // INTERACTOR -> MOCKDATAMANAGER
    //var remoteRequestHandler: MovieListMockDataManagerOutputProtocol? { get set }
    
    func getPopularMovies(success: @escaping (([Movie]) -> ()), failure: @escaping ((NetworkErrors) -> ()))
}


// MARK: - protocol MovieListMockDataManagerOutputProtocol
protocol MovieListMockDataManagerOutputProtocol: AnyObject {
    // MOCKDATAMANAGER -> INTERACTOR
}


// MARK: - MovieListMockDataManagerInputProtocol
class MovieListMockDataManager: MovieListMockDataManagerInputProtocol {
    
    //var remoteRequestHandler: MovieListMockDataManagerOutputProtocol?
    
    private func getMockedMovies() -> [Movie] {
        let movie1 = Movie(movieID: 634649, title: "Spider-Man: No Way Home", synopsis: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.", image: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg")
        let movie2 = Movie(movieID: 414906, title: "The Batman", synopsis: "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.", image: "/74xTEgt7R36Fpooo50r9T25onhq.jpg")
        let movie3 = Movie(movieID: 833425, title: "No Exit", synopsis: "Stranded at a rest stop in the mountains during a blizzard, a recovering addict discovers a kidnapped child hidden in a car belonging to one of the people inside the building which sets her on a terrifying struggle to identify who among them is the kidnapper.", image: "/5cnLoWq9o5tuLe1Zq4BTX4LwZ2B.jpg")
        let movie4 = Movie(movieID: 568124, title: "Encanto", synopsis: "The tale of an extraordinary family, the Madrigals, who live hidden in the mountains of Colombia, in a magical house, in a vibrant town, in a wondrous, charmed place called an Encanto. The magic of the Encanto has blessed every child in the family with a unique gift from super strength to the power to heal—every child except one, Mirabel. But when she discovers that the magic surrounding the Encanto is in danger, Mirabel decides that she, the only ordinary Madrigal, might just be her exceptional family's last hope.", image: "/4j0PNHkMr5ax3IA8tjtxcmPU3QT.jpg")
        let movie5 = Movie(movieID: 476669, title: "The King's Man", synopsis: "As a collection of history's worst tyrants and criminal masterminds gather to plot a war to wipe out millions, one man must race against time to stop them.", image: "/aq4Pwv5Xeuvj6HZKtxyd23e6bE9.jpg")
        
        let movies = [movie1, movie2, movie3, movie4, movie5]
        return movies
    }
    
    func getPopularMovies(success: @escaping (([Movie]) -> ()), failure: @escaping ((NetworkErrors) -> ())) {
        let movies = getMockedMovies()
        success(movies)
    }
    
}
