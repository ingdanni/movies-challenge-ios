//
//  ContentAdapter.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

protocol ContentAdapter {
    var id: Int { get }
    var contentTitle: String { get }
    var contentImage: String { get }
}
