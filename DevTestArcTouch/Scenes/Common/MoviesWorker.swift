//
//  MoviesWorker.swift
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

protocol MovieService {
    func requestMovies(page: Int,
                       success: @escaping (MovieResults) -> Void,
                       failure: @escaping (Error) -> Void)
    
    func requestSearchMovie(page: Int,
                            movieTitle: String,
                            success: @escaping (MovieResults) -> Void,
                            failure: @escaping (Error) -> Void)
    
    func requestMovieDetails(id: Int,
                             success: @escaping (Movie) -> Void,
                             failure: @escaping (Error) -> Void)
}

class MoviesWorker {
    var service: MovieService!
    
    init(service: MovieService) {
        self.service = service
    }
    
    
    func requestMovies(request: Movies.FetchMovies.Request,
                       success: @escaping (MovieResults) -> Void,
                       failure: @escaping (Error) -> Void = {_ in }) {
        
        self.service.requestMovies(page: request.page, success: { (movies) in
            success(movies)
            
        }) { (error) in
            failure(error)
            
        }
    }
    
    func requestSearchMovie(request: Movies.SearchMovie.Request,
                            success: @escaping (MovieResults) -> Void,
                            failure: @escaping (Error) -> Void = {_ in }) {
        
        self.service.requestSearchMovie(page: request.page, movieTitle: request.movieTitle, success: { (movies) in
            success(movies)
            
        }) { (error) in
            failure(error)
            
        }

    }
    
    func requestMovieDetails(request: MovieDetail.FetchMovieDetails.Request,
                             success: @escaping (Movie) -> Void,
                             failure: @escaping (Error) -> Void = {_ in }) {
        
        self.service.requestMovieDetails(id: request.movie!.id, success: { (movie) in
            success(movie)
            
        }) { (error) in
            failure(error)
        }

    }
    
    func doSomeWork() {
    }
    
    
}
