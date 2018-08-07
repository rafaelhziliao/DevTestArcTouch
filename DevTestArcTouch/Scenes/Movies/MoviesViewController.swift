//
//  MoviesViewController.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 03/08/2018.
//  Copyright (c) 2018 Rafael Zilião. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MoviesDisplayLogic: class {
    func displaySomething(viewModel: Movies.Something.ViewModel)
    func displayMovies(viewModel: Movies.FetchMovies.ViewModel)
    func displaySearchResults(viewModel: Movies.SearchMovie.ViewModel)
}

class MoviesViewController: UIViewController, MoviesDisplayLogic {
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        self.setupViews()
        self.fetchMovies()
    }
  
    // MARK: Do something
    
    func setupViews() {
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.backgroundColor = UIColor.Colors.primaryBackgroundColor
        self.moviesTableView.separatorColor = UIColor.Colors.borderColor
        
        self.findMovieSearchBar.tintColor = UIColor.Colors.grayColor
        self.findMovieSearchBar.barStyle = .black
        self.findMovieSearchBar.placeholder = "Find your favorite movie..."
        self.findMovieSearchBar.delegate = self
        self.findMovieSearchBar.enablesReturnKeyAutomatically = false
    }
  
    //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var findMovieSearchBar: UISearchBar!
    @IBOutlet var moviesTableView: UITableView!
    private var currentPage: Int = 0
    private var lastPage: Int = 0
    
    private var movies: [Movie] = [] {
        didSet {
            self.moviesTableView.reloadData()
        }
    }
    
    func doSomething() {
        let request = Movies.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func fetchMovies(page: Int = 1) {
        let request = Movies.FetchMovies.Request(page: page)
        self.interactor?.fetchMovies(request: request)
    }
    
    func searchMovie(movieTitle: String) {
        let request = Movies.SearchMovie.Request(movieTitle: movieTitle)
        self.interactor?.searchMovie(request: request)
    }
  
    func displaySomething(viewModel: Movies.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    func displayMovies(viewModel: Movies.FetchMovies.ViewModel) {
        viewModel.movieResults.movies.forEach{self.movies.append($0)}
        self.lastPage = viewModel.movieResults.numberOfPages
        self.currentPage = viewModel.movieResults.page
    }
    
    func displaySearchResults(viewModel: Movies.SearchMovie.ViewModel) {
        self.movies = viewModel.movieResults.movies
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = moviesTableView.dequeueReusableCell(withIdentifier: MovieListCell.identifier, for: indexPath) as? MovieListCell {
            
            cell.render(movie: self.movies[indexPath.row])
            
            return cell
        }
        else {
            return UITableViewCell()
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.movies.count - 1 {
            if self.currentPage <= self.lastPage {
                self.fetchMovies(page: self.currentPage + 1)
            }
        }
    }
    
}

extension MoviesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        let movieWanted: String
        if let _movieWanted = searchBar.text, !_movieWanted.isEmpty {
            movieWanted = _movieWanted
            self.searchMovie(movieTitle: movieWanted)
        }
        else {
            self.fetchMovies()
        }

    }
}
