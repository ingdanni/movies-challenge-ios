//
//  ContentRepository.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

protocol ContentProvider {
    func fetchMovies(page: Int, category: Category, completion: @escaping (Result<ContentResponse<Movie>, HTTPClientError>) -> Void)
    
    func fetchSeries(page: Int, category: Category, completion: @escaping (Result<ContentResponse<Serie>, HTTPClientError>) -> Void)
}

class ContentRepository: HTTPClient, ContentProvider {
    func fetchMovies(page: Int, category: Category, completion: @escaping (Result<ContentResponse<Movie>, HTTPClientError>) -> Void) {
        request(resource: ContentResource.getPage(.movie, category, page), type: ContentResponse<Movie>.self, completion: completion)
    }
    
    func fetchSeries(page: Int, category: Category, completion: @escaping (Result<ContentResponse<Serie>, HTTPClientError>) -> Void) {
        request(resource: ContentResource.getPage(.serie, category, page), type: ContentResponse<Serie>.self, completion: completion)
    }
}
