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
                    presenter: ContentPresenter(
                        interactor: ContentInteractor(
                            model: ContentModel(resourcesType: item))
                    )
                )
                .tabItem {
                    Image(systemName: "video.circle.fill") // FIXME: Handle icon
                    Text(item.title)
                }
            }
        }
    }
}
