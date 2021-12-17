//
//  ContentInteractor.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import Combine

class ContentInteractor {
    let model: ContentModel
    
    init(model: ContentModel) {
        self.model = model
    }
    
    func load(category: Category, for page: Int, reset: Bool = false) {
        model.load(category: category, for: page, reset: reset)
    }
}
