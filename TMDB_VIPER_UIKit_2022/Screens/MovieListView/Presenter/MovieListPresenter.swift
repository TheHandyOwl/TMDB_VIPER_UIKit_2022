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
    
    func getMovies()
    func goToDetailView(movieID: Int)
    func viewDidLoad()
    func viewWillAppear(dataHandler: ([Movie], [Movie], String) -> ())
    func viewWillDisappear(movies: [Movie], filteredMovies: [Movie], filteredString: String)
}


// MARK: - protocol MovieListInteractorOutputProtocol
protocol MovieListInteractorOutputProtocol: AnyObject {
    // INTERACTOR -> PRESENTER
}


// MARK: - MovieListPresenter
final class MovieListPresenter  {
    
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
