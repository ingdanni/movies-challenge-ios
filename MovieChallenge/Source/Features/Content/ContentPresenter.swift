//
//  ContentPresenter.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI
import Combine

class ContentPresenter: ObservableObject {
    private let interactor: ContentInteractor
    private let router = ContentRouter()
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var list: [ContentAdapter] = []
    
    @Published var selectedCategory: Category = .popular
    
    init(interactor: ContentInteractor) {
        self.interactor = interactor
        
        interactor.model.$list
            .assign(to: \.list, on: self)
            .store(in: &cancellables)
        
        $selectedCategory
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { category in
                interactor.load(category: category)
            })
            .store(in: &cancellables)
    }
}
