//
//  ContentModel.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI
import RealmSwift

final class ContentModel {
    
    private let resourcesType: ResourceType
    private let repository: ContentProvider
    
    @Published var list: [ContentAdapter] = []
    
    init(resourcesType: ResourceType, repository: ContentProvider) {
        self.resourcesType = resourcesType
        self.repository = repository
    }
    
    func load(category: Category, for page: Int, reset: Bool = false) {
        
        if reset {
            list = []
        }
        
        if resourcesType == .movies {
            repository.fetchMovies(page: page, category: category, completion: { [weak self] result in
                switch result {
                case .success(let response):
                    // save movies on cache
                    Cache.shared.setCollection(objects: response.results,
                                               with: self?.resourcesType ?? .movies,
                                               on: category)
                    
                    self?.list += response.results
                    
                case .failure(let error):
                    self?.loadFromCache(category: category)
                    
                    print(error)
                }
            })
            
        } else {
            repository.fetchSeries(page: page, category: category, completion: { [weak self] result in
                switch result {
                case .success(let response):
                    // save series on cache
                    Cache.shared.setCollection(objects: response.results,
                                               with: self?.resourcesType ?? .series,
                                               on: category)
                    
                    self?.list += response.results
                    
                case .failure(let error):
                    self?.loadFromCache(category: category)
                    
                    print(error)
                }
            })
        }
    }
    
    func search(_ text: String) {
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        
        if resourcesType == .movies {
            repository.searchMovies(query: query) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.list = response.results
                case .failure(let error):
                    print(error)
                    self?.searchOnCache(text)
                }
            }
            
        } else {
            repository.searchSeries(query: query) { [weak self] result in
                switch result {
                case .success(let response):
                    self?.list = response.results
                case .failure(let error):
                    print(error)
                    self?.searchOnCache(text)
                }
            }
        }
    }
    
    // MARK: Private methods
    
    private func loadFromCache(category: Category) {
        DispatchQueue.main.async {
            let cacheResult = Cache.shared.getCollection(of: category, with: self.resourcesType)
            self.list = cacheResult
        }
    }
    
    private func searchOnCache(_ text: String) {
        DispatchQueue.main.async {
            let cacheResult = Cache.shared.search(text, with: self.resourcesType)
            self.list = cacheResult
        }
    }
}
