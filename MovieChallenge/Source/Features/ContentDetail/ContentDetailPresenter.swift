//
//  ContentDetailPresenter.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 16/12/21.
//

import Combine

class ContentDetailPresenter: ObservableObject {
    private let interactor: ContentDetailInteractor
    private let router: ContentDetailRouter
    
    @Published var content: ContentAdapter
    
    init(content: ContentAdapter, interactor: ContentDetailInteractor) {
        self.content = content
        self.interactor = interactor
        self.router = ContentDetailRouter()
    }
}
