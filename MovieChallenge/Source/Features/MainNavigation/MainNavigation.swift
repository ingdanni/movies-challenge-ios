//
//  MainNavigation.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI

struct MainNavigation: View {
    
    var body: some View {
        TabView {
            ForEach(ResourceType.allCases, id: \.rawValue) { item in
                ContentView(
                    title: item.title,
                    tabs: item.categories,
                    presenter: ContentPresenter(
                        interactor: ContentInteractor(
                            model: ContentModel(resourcesType: item,
                                                repository: ContentRepository(
                                                    configuration: HTTPClientConfiguration.default)))
                    )
                )
                .tabItem {
                    Image(systemName: item.icon)
                    Text(item.title)
                }
            }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .black
        }
    }
}
