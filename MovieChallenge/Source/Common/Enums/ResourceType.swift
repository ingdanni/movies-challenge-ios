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
}
