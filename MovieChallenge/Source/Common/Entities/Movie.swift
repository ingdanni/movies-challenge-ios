//
//  Movie.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie: ContentAdapter {
    
    var contentId: Int {
        id
    }
    
    var contentTitle: String {
        title
    }
    
    var contentOverview: String {
        overview
    }
    
    var contentImage: String {
        if let postPath = posterPath {
            return kImageUrl + postPath
        }
        
        return ""
    }
}
