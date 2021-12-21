//
//  SeriesTest.swift
//  MovieChallengeTests
//
//  Created by Danny Narvaez on 19/12/21.
//

import Nimble
import Quick

@testable import MovieChallenge

final class SeriesTest: QuickSpec {
    
    override func spec() {
        var model: ContentModel!
        
        beforeEach {
            model = ContentModel(
                resourcesType: .series,
                repository: ContentRepositoryMock())
        }
        
        afterEach {
            model = nil
        }
        
        describe("Content Model tests") {
            
            it("Should get popular series") {
                let expectation = QuickSpec.current.expectation(description: "fetch popular series")
                
                model.load(category: .popular, for: 1, reset: false)
                
                _ = model.$list.sink(receiveValue: { value in
                    guard !value.isEmpty else { return }
                    expectation.fulfill()
                })
                
                expect(model.list.count).to(equal(20))
                
                QuickSpec.current.wait(for: [expectation], timeout: 5.0)
            }
            
            it("Should search series") {
                let expectation = QuickSpec.current.expectation(description: "search series")
                
                model.search("doctor")
                
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
