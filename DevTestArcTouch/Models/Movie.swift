//
//  Movie.swift
//  DevTestArcTouch
//
//  Created by Rafael Zilião on 01/08/2018.
//  Copyright © 2018 Rafael Zilião. All rights reserved.
//

import Foundation

struct Movie {
    let id: Int
    let posterPath: String
    let backDrop: String
    let title: String
    var releaseDate: String
    let overview: String
    let voteAverage: Double
}

extension Movie: Decodable {
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backDrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case overview
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        backDrop = try container.decode(String.self, forKey: .backDrop)
        title = try container.decode(String.self, forKey: .title)
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        overview = try container.decode(String.self, forKey: .overview)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
    }
}
