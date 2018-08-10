//
//  MovieDetailInteractor.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 07/08/2018.
//  Copyright (c) 2018 Rafael Zilião. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailBusinessLogic {
    func doSomething(request: MovieDetail.Something.Request)
    func fetchMovieDetails(request: MovieDetail.FetchMovieDetails.Request)
}

protocol MovieDetailDataStore {
  var movie: Movie! { get set }
}

class MovieDetailInteractor: MovieDetailBusinessLogic, MovieDetailDataStore {
    var presenter: MovieDetailPresentationLogic?
    var worker: MoviesWorker?
    var movie: Movie!
    
    // MARK: Do something
    
    init () {
        self.worker = MoviesWorker(service: MovieRestApi())
    }
    
    func doSomething(request: MovieDetail.Something.Request) {
//        worker = MovieDetailWorker()
//        worker?.doSomeWork()
//
//        let response = MovieDetail.Something.Response()
//        presenter?.presentSomething(response: response)
    }
    
    func fetchMovieDetails(request: MovieDetail.FetchMovieDetails.Request) {
        var updatedRequest = request
        updatedRequest.movie = self.movie
        self.worker?.requestMovieDetails(request: updatedRequest, success: {[weak self] (movie) in
            self?.movie.genres = movie.genres
            self?.movie.tagline = movie.tagline
            self?.movie.runtime = movie.runtime
            
            guard let _movie = self?.movie else {
                return
            }
            
            let response = MovieDetail.FetchMovieDetails.Response(movie: _movie)
            self?.presenter?.presentMovieDetails(response: response)
            
        },
        failure: {[weak self] (error) in
                let response = MovieDetail.ErrorFetchMovieDetais.Response(message: error.localizedDescription)
                self?.presenter?.presentErrorFetchMovieDetails(response: response)
        })
        
    }
}
