//
//  Resource.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

public protocol Resource {
    
    var resource: (method: HTTPMethod, route: String, contentType: ContentType?) { get }
}
