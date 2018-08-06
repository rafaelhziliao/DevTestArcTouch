//
//  MovieApi.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 02/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import Foundation
import Moya

enum MovieApi {
    case newMovies(page: Int)
    case search(movieTitle: String)
}

extension MovieApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("baseURL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .newMovies:
            return "/movie/now_playing"
        case .search:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .newMovies, .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        switch self {
        case .newMovies(let page):
            return ["page": page, "api_key": NetworkManager.apiKey]
        case .search(let movieTitle):
            return ["api_key": NetworkManager.apiKey, "query": movieTitle]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .newMovies, .search:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .newMovies, .search:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
