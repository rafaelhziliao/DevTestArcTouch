//
//  MoviesInteractor.swift
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

protocol MoviesBusinessLogic {
    func doSomething(request: Movies.Something.Request)
    func fetchMovies(request: Movies.FetchMovies.Request)
    func searchMovie(request: Movies.SearchMovie.Request)
}

protocol MoviesDataStore {
    //var name: String { get set }
}

class MoviesInteractor: MoviesBusinessLogic, MoviesDataStore {
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker?
    //var name: String = ""
  
    init () {
        self.worker = MoviesWorker(service: MovieRestApi())
    }
    
    // MARK: Do something
  
    func doSomething(request: Movies.Something.Request) {
//        worker = MoviesWorker()
//        worker?.doSomeWork()
//
//        let response = Movies.Something.Response()
//        presenter?.presentSomething(response: response)
    }
    
    func fetchMovies(request: Movies.FetchMovies.Request) {
        self.worker?.requestMovies(request: request, success: { [weak self] (moviesResults) in
            let response = Movies.FetchMovies.Response(movieResults: moviesResults)
            self?.presenter?.presentFetchedMovies(response: response)
            }, failure: { [weak self] (error) in
            let response = Movies.Error.Response(message: error.localizedDescription)
            self?.presenter?.presentFetchError(response: response)
        })
    }
    
    func searchMovie(request: Movies.SearchMovie.Request) {
        self.worker?.requestSearchMovie(request: request, success: { [weak self] (moviesResults) in
            let response = Movies.SearchMovie.Response(movieResults: moviesResults)
            self?.presenter?.presentWantedMovie(response: response)
            }, failure: { [weak self] (error) in
                let response = Movies.Error.Response(message: error.localizedDescription)
                self?.presenter?.presentFetchError(response: response)
        })
    }

}
