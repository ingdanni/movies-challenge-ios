//
//  ContentModelTest.swift
//  MovieChallengeTests
//
//  Created by Danny Narvaez on 19/12/21.
//

import Nimble
import Quick

@testable import MovieChallenge

final class MoviesTest: QuickSpec {
    
    override func spec() {
        var model: ContentModel!
        
        beforeEach {
            model = ContentModel(
                resourcesType: .movies,
                repository: ContentRepositoryMock())
        }
        
        afterEach {
            model = nil
        }
        
        describe("Content Model tests") {
            
            it("Should get popular movies") {
                let expectation = QuickSpec.current.expectation(description: "fetch popular movies")
                
                model.load(category: .popular, for: 1, reset: false)
                
                _ = model.$list.sink(receiveValue: { value in
                    guard !value.isEmpty else { return }
                    expectation.fulfill()
                })
                
                expect(model.list.count).to(equal(20))
                
                QuickSpec.current.wait(for: [expectation], timeout: 5.0)
            }
            
            it("Should search movies") {
                let expectation = QuickSpec.current.expectation(description: "search movies")
                
                model.search("spider man")
                
                _ = model.$list.sink(receiveValue: { value in
                    guard !value.isEmpty else { return }
                    expectation.fulfill()
                })
                
                expect(model.list.count).to(equal(20))
                
                QuickSpec.current.wait(for: [expectation], timeout: 5.0)
            }
        }
    }
}
