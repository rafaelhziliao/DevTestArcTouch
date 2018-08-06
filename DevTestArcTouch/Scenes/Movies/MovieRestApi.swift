//
//  MovieRestApi.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 04/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import Foundation

class MovieRestApi: MovieService {
    
    func requestMovies(page: Int,
                       success: @escaping (MovieResults) -> Void,
                       failure: @escaping (Error) -> Void = {_ in } ) {
        
        MovieResults.requestNewMovies(page: page, success: { (movies) in
            success(movies)
        }) { (error) in
            failure (error)
            
        }
    }
    
    func requestSearchedMovie(movieTitle: String,
                              success: @escaping (MovieResults) -> Void,
                              failure: @escaping (Error) -> Void = {_ in } ) {
        
        MovieResults.requestSearchedMovie(movieTitle: movieTitle, success: { (movies) in
            success(movies)
        }) { (error) in
            failure (error)
            
        }

    }
    
}
