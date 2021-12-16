//
//  ContentModel.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI
import RealmSwift

final class ContentModel {
    
    private let client: ContentProvider
    private let resourcesType: ResourceType
    
    @Published var list: [ContentAdapter] = []
    
    init(resourcesType: ResourceType) {
        self.resourcesType = resourcesType
        
        let configuration = HTTPClientConfiguration(baseURL: kBaseUrl, apiKey: kApiKey)

        client = ContentRepository(configuration: configuration)
    }
    
    func load(category: Category) {
        list = []
        
        if resourcesType == .movies {
            client.fetchMovies(page: 1, category: category, completion: { [weak self] result in
                switch result {
                case .success(let response):
                    // save movies on cache
                    Cache.shared.setCollection(objects: response.results,
                                               with: self?.resourcesType ?? .movies,
                                               on: category)
                    
                    DispatchQueue.main.async {
                        self?.list = response.results
                    }
                    
                case .failure(let error):
                    self?.loadFromCache(category: category, with: self?.resourcesType ?? .movies)
                    
                    print(error)
                }
            })
            
        } else {
            client.fetchSeries(page: 1, category: category, completion: { [weak self] result in
                switch result {
                case .success(let response):
                    // save series on cache
                    Cache.shared.setCollection(objects: response.results,
                                               with: self?.resourcesType ?? .series,
                                               on: category)
                    
                    DispatchQueue.main.async {
                        self?.list = response.results
                    }
                    
                case .failure(let error):
                    self?.loadFromCache(category: category, with: self?.resourcesType ?? .series)
                    
                    print(error)
                }
            })
        }
    }
    
    private func loadFromCache(category: Category, with resourceType: ResourceType) {
        DispatchQueue.main.async {
            let cacheResult = Cache.shared.getCollection(of: category, with: resourceType)
            self.list = cacheResult
        }
    }
}
