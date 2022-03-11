//
//  MovieListView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation
import RxCocoa
import RxSwift
import UIKit


// MARK: - protocol MovieListViewProtocol
protocol MovieListViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: MovieListPresenterProtocol? { get set }
    
    func refreshList(movies: [Movie])
    func setupUI(viewTitle: String)
    func startActivity()
    func stopActivity()
}


// MARK: - MovieListView
final class MovieListView: UIViewController {
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Properties
    var presenter: MovieListPresenterProtocol?
    
    private var disposeBag = DisposeBag()
    
    private var filteredMovies: [Movie] = []
    
    private var movies: [Movie] = []
    
    private lazy var searchController: UISearchController = {
        ControllerFactory.shared.createUISearchController(placeholderText: Constants.Views.MovieList.searchBarPlaceholder)
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSearchControllerAndDelegate()
        registerCell()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear() { movies, searchString in
            if searchString != "" {
                searchController.isActive = true
                searchController.searchBar.text = searchString
                filteredMovies = movies
                reloadTable()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.viewWillDisappear(filteredMovies: filteredMovies, filteredString: searchController.searchBar.text ?? "")
        searchController.isActive = false
    }
    
    
    // MARK: Private methods
    private func configSearchControllerAndDelegate() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        
        let searchBar = searchController.searchBar
        tableView.tableHeaderView = searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchBar.frame.height)
        
        searchBar.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe { titleString in
                if titleString == "" {
                    self.filteredMovies = self.movies
                } else {
                    self.filteredMovies = self.movies.filter { movie in
                        movie.title.lowercased().contains(titleString.lowercased()) == true
                    }
                }
                self.reloadTable()
            } onError: { error in
                print("\(Constants.Strings.errorLiteral): \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
        
    }
    
    private func getMoviesOrFilteredMovies() -> [Movie] {
        let isFiltering = searchController.searchBar.text != ""
        return isFiltering ? filteredMovies: movies
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: Constants.Views.MovieList.MovieCell.nibName, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: Constants.Views.MovieList.MovieCell.cellID)
    }
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


// MARK: - UISearchControllerDelegate
extension MovieListView: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        searchController.isActive = false
        reloadTable()
    }
}


// MARK: - UISearchControllerDelegate
extension MovieListView: UISearchControllerDelegate {
}


// MARK: - UITableViewDataSource
extension MovieListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let movies = getMoviesOrFilteredMovies()
        let items = movies.count
        return items
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let movies = getMoviesOrFilteredMovies()
        let item = movies[row]
        
        // Fetching more pages?
        let fetchMovies = (row >= movies.count - 7) && searchController.searchBar.text == "" && activityIndicator.isHidden
        if fetchMovies {
            presenter?.getMovies()
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Views.MovieList.MovieCell.cellID) as? MovieListCellView {
            cell.configureCell(movieTitle: item.title, movieSinopsis: item.synopsis, image: item.image)
            return cell
        }
        
        let cell = UITableViewCell()
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let movies = getMoviesOrFilteredMovies()
        let item = movies[row]
        let movieId = item.movieID
        
        presenter?.goToDetailView(movieId: movieId)
    }
}


// MARK: - MovieListViewProtocol
extension MovieListView: MovieListViewProtocol {
    
    func refreshList(movies: [Movie]) {
        self.movies += movies
        reloadTable()
    }
    
    func setupUI(viewTitle: String) {
        self.title = viewTitle
    }
    
    func startActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        DispatchQueue.main.async {
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.stopAnimating()
        }
    }
    
}
