//
//  ResourceType.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

enum ResourceType: String, CaseIterable {
    case movie
    case serie = "tv"
}

extension ResourceType {
    
    var title: String {
        switch self {
        case .movie:
            return "Movies"
        case .serie:
            return "Series"
        }
    }
}
