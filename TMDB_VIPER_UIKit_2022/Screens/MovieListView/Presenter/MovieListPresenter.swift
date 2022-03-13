//
//  MovieListPresenter.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation


// MARK: - protocol MovieListPresenterProtocol
protocol MovieListPresenterProtocol: AnyObject {
    // VIEW -> PRESENTER
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var wireFrame: MovieListWireFrameProtocol? { get set }
    
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping (() -> ()))
    func getMovies()
    func goToDetailView(movieID: Int)
    func toggleFavorite(movie: Movie, movies: [Movie], filteredMovies: [Movie])
    func viewDidLoad()
    func viewWillAppear(dataHandler: ([Movie], [Movie], String) -> ())
    func viewWillDisappear(movies: [Movie], filteredMovies: [Movie], filteredString: String)
}


// MARK: - protocol MovieListInteractorOutputProtocol
protocol MovieListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}


// MARK: - MovieListPresenter
class MovieListPresenter  {
    
    // MARK: Properties
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorInputProtocol?
    var wireFrame: MovieListWireFrameProtocol?
    
    private var filteredMoviesBackUp = [Movie]()
    private var filteredStringBackUp = ""
    private var moviesBackUp = [Movie]()
    
}


// MARK: - MovieListPresenterProtocol
extension MovieListPresenter: MovieListPresenterProtocol {
    
    func addOrRemoveFavorite(movie: Movie, success: @escaping (() -> ()), failure: @escaping (() -> ())) {
        interactor?.addOrRemoveFavorite(movie: movie, success: {
            success()
        }, failure: { coreDataError in
            print("\(Constants.Strings.errorLiteral): \(coreDataError)")
            failure()
        })
    }
    
    func getMovies() {
        view?.startActivity()
        
        DispatchQueue.global().async {
            self.interactor?.getPopularMovies(success: { [weak self] movies in
                self?.view?.addMoviesAndRefreshList(movies: movies)
                self?.view?.stopActivity()
            }, failure: { [weak self] networkError in
                self?.view?.stopActivity()
                if (networkError != .noRequest) && (networkError != .pageLimitReached) {
                    self?.getMovies()
                    print("\(Constants.Strings.errorLiteral): \(networkError)")
                    return
                }
            })
        }
    }
    
    func goToDetailView(movieID: Int) {
        guard let view = view else { return }
        
        wireFrame?.goToDetailView(view: view, movieID: movieID)
    }
    
    func toggleFavorite(movie: Movie, movies: [Movie], filteredMovies: [Movie]) {
        let newMovies = movies.map { oldMovie -> Movie in
            let toggledMovie: Movie = (oldMovie.movieID == movie.movieID) ? Movie(
                movieID: oldMovie.movieID,
                title: oldMovie.title,
                synopsis: oldMovie.synopsis,
                image: oldMovie.image,
                favorite: !oldMovie.favorite
            ) : oldMovie
            return toggledMovie
        }
        let newFilteredMovies = filteredMovies.map { oldMovie -> Movie in
            let toggledMovie: Movie = (oldMovie.movieID == movie.movieID) ? Movie(
                movieID: oldMovie.movieID,
                title: oldMovie.title,
                synopsis: oldMovie.synopsis,
                image: oldMovie.image,
                favorite: !oldMovie.favorite
            ) : oldMovie
            return toggledMovie
        }
        
        view?.refreshFavorites(movies: newMovies, filteredMovies: newFilteredMovies)
    }
    
    func viewDidLoad() {
        let viewTitle = Constants.Views.MovieList.title
        view?.setupUI(viewTitle: viewTitle)
        
        getMovies()
    }
    
    func viewWillAppear(dataHandler: ([Movie], [Movie], String) -> ()) {
        dataHandler(moviesBackUp, filteredMoviesBackUp, filteredStringBackUp)
    }
    
    func viewWillDisappear(movies: [Movie], filteredMovies: [Movie], filteredString: String) {
        moviesBackUp = movies
        filteredMoviesBackUp = filteredMovies
        filteredStringBackUp = filteredString
    }
    
}


// MARK: - MovieListInteractorOutputProtocol
extension MovieListPresenter: MovieListInteractorOutputProtocol {
}
