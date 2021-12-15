//
//  ContentModel.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI

final class ContentModel {
    
    private let client: ContentProvider
    private let resourcesType: ResourceType
    
    @Published var list: [ContentAdapter] = []
    
    init(resourcesType: ResourceType) {
        self.resourcesType = resourcesType
        
        let configuration = HTTPClientConfiguration(
            baseURL: "https://api.themoviedb.org/3",
            apiKey: "f4dd39f0bedfabac6db5e3a6af1817c3")

        client = ContentRepository(configuration: configuration)
    }
    
    func load(category: Category) {
        if resourcesType == .movie {
            client.fetchMovies(page: 1, category: category, completion: { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.list = response.results
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
            
        } else {
            client.fetchSeries(page: 1, category: category, completion: { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.list = response.results
                    }
                    
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
}
