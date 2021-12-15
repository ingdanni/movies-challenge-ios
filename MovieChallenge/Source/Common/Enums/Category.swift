//
//  Category.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import Combine

enum Category: String, CaseIterable {
    case popular
    case topRated = "top_rated"
    case upcoming
}

extension Category {
    
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .topRated:
            return "Top rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}
