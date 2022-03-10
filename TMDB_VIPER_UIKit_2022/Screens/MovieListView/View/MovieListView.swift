//
//  MovieListView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 10/3/22.
//  
//

import Foundation
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
class MovieListView: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = [] {
        didSet {
            movies.sort { $0.title < $1.title }
        }
    }
    
    // MARK: Properties
    var presenter: MovieListPresenterProtocol?

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        presenter?.viewDidLoad()
    }
    
    private func registerCell() {
        let cellNib = UINib(nibName: Constants.Views.MovieList.MovieCell.nibName, bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: Constants.Views.MovieList.MovieCell.cellID)
    }
    
}


// MARK: - UITableViewDataSource
extension MovieListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = movies[row]
        
        // Fetching more pages?
        if ( (row >= movies.count - 7) && (activityIndicator.isHidden) ) {
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
        let item = movies[row]
        
        print("Item: \(item.title)")
    }
}


// MARK: - MovieListViewProtocol
extension MovieListView: MovieListViewProtocol {
    
    func refreshList(movies: [Movie]) {
        self.movies += movies
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
