//
//  MovieResults.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 01/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import Foundation

struct MovieResults {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieResults: Decodable {
    
    private enum ResultsCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResultsCodingKeys.self)
        
        page =  try container.decode(Int.self, forKey: .page)
        numberOfResults = try  container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
    }
    
    public static func requestNewMovies(page: Int,
                                        success: @escaping (MovieResults) -> Void,
                                        failure: @escaping (Error) -> Void = {_ in }) {
        
            
        NetworkManager.provider.request(.newMovies(page: page)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(MovieResults.self, from: response.data)
                    success(results)
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                failure(error)
            }
        }
    }
}
