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
    
    private var currentPage: Int = 1
    
    init(interactor: ContentInteractor) {
        self.interactor = interactor
        
        interactor.model.$list
            .assign(to: \.list, on: self)
            .store(in: &cancellables)
        
        $selectedCategory
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { category in
                self.currentPage = 1
                
                interactor.load(category: category, for: self.currentPage, reset: true)
            })
            .store(in: &cancellables)
    }
    
    func detailLinkBuilder<Content: View>(
        for item: ContentAdapter,
        @ViewBuilder content: () -> Content) -> some View {
        
        NavigationLink(destination: router.makeDetailView(for: item)) {
            content()
        }
    }
    
    func loadMore() {
        guard currentPage < 500 else { return }
        
        currentPage += 1
        
        interactor.load(category: selectedCategory, for: currentPage)
    }
}
