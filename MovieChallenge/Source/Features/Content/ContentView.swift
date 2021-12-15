//
//  ContentView.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var title: String
    
    @ObservedObject var presenter: ContentPresenter
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false, content: {
                    HStack {
                        ForEach(Category.allCases, id: \.rawValue) { item in
                            Button(item.title, action: {
                                presenter.selectedCategory = item
                            })
                        }
                    }
                    .padding(.horizontal, 8)
                })
                
                List {
                    ForEach(presenter.list, id: \.id) { item in
                        Text(item.contentTitle)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}
