//
//  FavoritesView.swift
//  TMDB_VIPER_UIKit_2022
//
//  Created by Carlos on 11/3/22.
//  
//

import Foundation
import UIKit


// MARK: - protocol FavoritesViewProtocol
protocol FavoritesViewProtocol: AnyObject {
    // PRESENTER -> VIEW
    var presenter: FavoritesViewPresenterProtocol? { get set }
    
    func refreshData(favorites: [String])
    func setupUI(withTitle: String)
    
    
    func startActivity()
    func stopActivity()
}


// MARK: - FavoritesView
class FavoritesView: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: Properties
    var presenter: FavoritesViewPresenterProtocol?
    
    private var favorites = [String]()
    
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    
    // MARK: Private methods
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}


// MARK: - FavoritesViewProtocol
extension FavoritesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favorites = presenter?.favoritesData ?? [String]()
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let favorites = presenter?.favoritesData ?? [String]()
        let item = favorites[row]
        
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = item
        cell.contentConfiguration = content
        return cell
    }
    
}


// MARK: - FavoritesViewProtocol
extension FavoritesView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteContextualAction = UIContextualAction(style: .destructive, title: Constants.Strings.deleteLiteral.capitalizingFirstLetter()) { [weak self] (contextualAction, view, completionHandler) in
            guard let presenter = self?.presenter else { return }
            
            let row = indexPath.row
            let item = presenter.favoritesData[row]
            
            presenter.removeFavorite(movieId: item)
            completionHandler(true)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteContextualAction])
        return swipeActions
    }
}


// MARK: - FavoritesViewProtocol
extension FavoritesView: FavoritesViewProtocol {

    func refreshData(favorites: [String]) {
        self.favorites = favorites
        reloadTable()
    }
    
    func setupUI(withTitle: String) {
        self.title = withTitle
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
