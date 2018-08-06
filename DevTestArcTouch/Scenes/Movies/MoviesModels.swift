//
//  MoviesModels.swift
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

enum Movies {
    // MARK: Use cases
  
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum FetchMovies {
        struct Request {
            var page: Int
        }
        
        struct Response {
            var movieResults: MovieResults
        }
        
        struct ViewModel {
            var movieResults: MovieResults
        }
    }
    
    enum Error {
        struct Request {
        }
        struct Response {
            var message: String
        }
        struct ViewModel {
            var message: String
        }
    }

}
