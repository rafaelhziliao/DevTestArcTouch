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
    let posterPath: String?
    let backDrop: String?
    let title: String
    let releaseDate: String?
    let overview: String?
    let voteAverage: Double?
    var genres: [Genre]?
    var runtime: Int?
    var tagline: String?
    
    var formatedRunTime: String? {
        get {
            if self.runtime == nil {
                return nil
            }
            
            let minute = self.runtime! % 60
            let hour = (self.runtime! - minute) / 60
            return "\(hour) h" + (minute > 0 ? " \(minute) min" : "")
        }
    }
    
    private let imageURLPrefix = "https://image.tmdb.org/t/p"
    
    enum ImageSize: Int {
       case small = 0
       case medium = 1
       case lager = 2
    }
    
    func posterPath(size: ImageSize) -> String {
        if posterPath == nil {
            return "https://www.movieinsider.com/images/none_175px.jpg"
        }
        
        switch size {
        case .small:
            return  "\(imageURLPrefix)/w185\(posterPath!)"
            
        default:
            return  "\(imageURLPrefix)/w500\(posterPath!)"
        }
    }
    
}

extension Movie: Decodable {
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backDrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case overview
        case voteAverage = "vote_average"
        case runtime
        case genres
        case tagline
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        posterPath = try? container.decode(String.self, forKey: .posterPath)
        backDrop = try? container.decode(String.self, forKey: .backDrop)
        title = try container.decode(String.self, forKey: .title)
        releaseDate = try? container.decode(String.self, forKey: .releaseDate)
        overview = try? container.decode(String.self, forKey: .overview)
        voteAverage = try? container.decode(Double.self, forKey: .voteAverage)
        runtime = try? container.decode(Int.self, forKey: .runtime)
        genres = try? container.decode([Genre].self, forKey: .genres)
        tagline = try? container.decode(String.self, forKey: .tagline)
        
    }
    
    public static func requestMovieDetails(id: Int,
                                           success: @escaping (Movie) -> Void,
                                           failure: @escaping (Error) -> Void = {_ in }) {
        
        NetworkManager.provider.request(.movieDetails(id: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Movie.self, from: response.data)
                    print(results)
                    DispatchQueue.main.async {
                        success(results)
                    }
                } catch let err {
                    print(err)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }

        
    }

}
