//
//  ContentResource.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

enum ContentResource: Resource {
    case getPage(String, String, Int)
    case search(String, String)
    
    var resource: (method: HTTPMethod, route: String, contentType: ContentType?) {
        switch self {
        case .getPage(let resourceType, let category, let page):
            return (.get, "/\(resourceType)/\(category)?page=\(page)", nil)
            
        case .search(let resourceType, let query):
            return (.get, "/search/\(resourceType)?query=\(query)", nil)
        }
    }
}
