//
//  ContentEntity+Adapter.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 16/12/21.
//

import RealmSwift

class ContentEntity: Object {
    @Persisted var id = 0
    @Persisted var title = ""
    @Persisted var overview = ""
    @Persisted var image = ""
    @Persisted var resourceType = ""
    @Persisted var category = ""
    
    override class func primaryKey() -> String? {
        "id"
    }
}

extension ContentEntity: ContentAdapter {
    var contentId: Int {
        id
    }
    
    var contentTitle: String {
        title
    }
    
    var contentOverview: String {
        overview
    }
    
    var contentImage: String {
        image
    }
}
