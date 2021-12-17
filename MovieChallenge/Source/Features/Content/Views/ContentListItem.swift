//
//  ContentListItem.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 17/12/21.
//

import SwiftUI

struct ContentListItem: View {
    var title: String
    var url: String
    
    var body: some View {
        Group {
            ZStack {
                AsyncImage(
                    url: url,
                    placeholder: {
                        Image(systemName: "play.square")
                            .font(.system(size: 200))
                            .frame(maxWidth: .infinity, idealHeight: 250)
                            .foregroundColor(Color.gray)
                    }, image: {
                        Image(uiImage: $0)
                            .resizable()
                    })
                    .frame(idealWidth: UIScreen.main.bounds.width / 2 * 3)
                
                Text(title)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .background(Color.black.opacity(0.8))
                    .offset(x: 0, y: 100)
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: 260)
        .padding(8)
    }
}

struct ContentListItem_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ContentListItem(title: "Pulp fiction",
                            url: "https://image.tmdb.org/t/p/w500/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg")
            
            ContentListItem(title: "Pulp fiction",
                            url: "https://image.tmdb.org/t/p/w500/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg")
        }
        .listStyle(PlainListStyle())
        .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
        .preferredColorScheme(.dark)
    }
}
