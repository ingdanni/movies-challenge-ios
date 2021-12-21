//
//  ResourceType.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

enum ResourceType: String, CaseIterable {
    case movies = "movie"
    case series = "tv"
}

extension ResourceType {
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .series:
            return "Series"
        }
    }
    
    var icon: String {
        switch self {
        case .movies:
            return "hexagon"
        case .series:
            return "diamond"
        }
    }
    
    var categories: [Category] {
        switch self {
        case .movies:
            return Category.allCases
        case .series:
            // On tv shows there is not upcoming category
            return [Category.popular, Category.topRated]
        }
    }
}
