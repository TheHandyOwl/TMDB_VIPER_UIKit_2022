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
    func goToDetailView(movieId: Int)
    func viewDidLoad()
    func viewWillAppear(dataHandler: ([Movie], String) -> ())
    func viewWillDisappear(filteredMovies: [Movie], filteredString: String)
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
    
}


// MARK: - MovieListPresenterProtocol
extension MovieListPresenter: MovieListPresenterProtocol {
    
    func getMovies() {
        view?.startActivity()
        
        DispatchQueue.global().async {
            self.interactor?.getPopularMovies(success: { [weak self] movies in
                self?.view?.refreshList(movies: movies)
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
    
    func goToDetailView(movieId: Int) {
        guard let view = view else { return }
        
        let movieIdAsString = String(movieId)
        wireFrame?.goToDetailView(view: view, movieId: movieIdAsString)
    }
    
    func viewDidLoad() {
        let viewTitle = Constants.Views.MovieList.title
        view?.setupUI(viewTitle: viewTitle)
        
        getMovies()
    }
    
    func viewWillAppear(dataHandler: ([Movie], String) -> ()) {
        dataHandler(filteredMoviesBackUp, filteredStringBackUp)
    }
    
    func viewWillDisappear(filteredMovies: [Movie], filteredString: String) {
        filteredMoviesBackUp = filteredMovies
        filteredStringBackUp = filteredString
    }
        
}


// MARK: - MovieListInteractorOutputProtocol
extension MovieListPresenter: MovieListInteractorOutputProtocol {
}
