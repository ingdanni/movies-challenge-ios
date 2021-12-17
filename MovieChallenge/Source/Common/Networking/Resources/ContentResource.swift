//
//  ContentResource.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 15/12/21.
//

enum ContentResource: Resource {
    case getPage(ResourceType, Category, Int)
    case search(ResourceType, String)
    
    var resource: (method: HTTPMethod, route: String, contentType: ContentType?) {
        switch self {
        case .getPage(let resourceType, let category, let page):
            return (.get, "/\(resourceType.rawValue)/\(category.rawValue)?page=\(page)", nil)
            
        case .search(let resourceType, let query):
            return (.get, "/search/\(resourceType.rawValue)?query=\(query)", nil)
        }
    }
}
