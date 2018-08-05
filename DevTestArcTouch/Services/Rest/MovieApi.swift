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
    case recommended(id: Int)
    case topRated(page: Int)
    case newMovies(page: Int)
}

extension MovieApi: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/") else {
            fatalError("baseURL could not be configured")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .topRated:
            return "popular"
        case .newMovies:
            return "now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .recommended, .topRated, .newMovies:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var parameters: [String: Any] {
        switch self {
        case .recommended:
            return ["api_key": NetworkManager.apiKey]
        case .topRated(let page), .newMovies(let page):
            return ["page": page, "api_key": NetworkManager.apiKey]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .recommended, .topRated, .newMovies:
            return URLEncoding.queryString
        }
    }
    
    var task: Task {
        switch self {
        case .recommended, .topRated, .newMovies:
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
