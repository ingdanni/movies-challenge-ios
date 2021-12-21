//
//  MockClient.swift
//  MovieChallengeTests
//
//  Created by Danny Narvaez on 19/12/21.
//

import Foundation
@testable import MovieChallenge

enum KindOfTest {
    case success
    case failure
}

class MockClient {
    
    var kindOfTest: KindOfTest = .success
    
    func loadFrom<T: Decodable>(_ file: String, type: T.Type) -> T {
        
        let bundle = Bundle(for: MockClient.self)
        
        guard let url = bundle.url(forResource: file, withExtension: "json"),
              let jsonData = try? Data(contentsOf: url),
              let response = try? JSONDecoder().decode(T.self, from: jsonData) else {
            abort()
        }
        
        return response
    }
}
