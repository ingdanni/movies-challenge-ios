//
//  ContentRepositoryMock.swift
//  MovieChallengeTests
//
//  Created by Danny Narvaez on 19/12/21.
//

@testable import MovieChallenge

class ContentRepositoryMock: MockClient, ContentProvider {
    
    func fetchMovies(page: Int, category: Category, completion: @escaping (Result<ContentResponse<Movie>, HTTPClientError>) -> Void) {
        switch kindOfTest {
        case .success:
            let response = loadFrom("movies_popular", type: ContentResponse<Movie>.self)
            completion(.success(response))
            
        case .failure:
            let statusCode = StatusCode(rawValue: 500)
            completion(.failure(.httpError(statusCode!)))
        }
    }
    
    func fetchSeries(page: Int, category: Category, completion: @escaping (Result<ContentResponse<Serie>, HTTPClientError>) -> Void) {
        switch kindOfTest {
        case .success:
            let response = loadFrom("series_popular", type: ContentResponse<Serie>.self)
            completion(.success(response))
            
        case .failure:
            let statusCode = StatusCode(rawValue: 500)
            completion(.failure(.httpError(statusCode!)))
        }
    }
    
    func searchMovies(query: String, completion: @escaping (Result<ContentResponse<Movie>, HTTPClientError>) -> Void) {
        switch kindOfTest {
        case .success:
            let response = loadFrom("movies_search", type: ContentResponse<Movie>.self)
            completion(.success(response))
            
        case .failure:
            let statusCode = StatusCode(rawValue: 500)
            completion(.failure(.httpError(statusCode!)))
        }
    }
    
    func searchSeries(query: String, completion: @escaping (Result<ContentResponse<Serie>, HTTPClientError>) -> Void) {
        switch kindOfTest {
        case .success:
            let response = loadFrom("series_search", type: ContentResponse<Serie>.self)
            completion(.success(response))
            
        case .failure:
            let statusCode = StatusCode(rawValue: 500)
            completion(.failure(.httpError(statusCode!)))
        }
    }
}
