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
    
    func load(category: Category) {
        model.load(category: category)
    }
}
