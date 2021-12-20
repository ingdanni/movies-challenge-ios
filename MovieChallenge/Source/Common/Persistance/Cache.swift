//
//  Cache.swift
//  MovieChallenge
//
//  Created by Danny Narvaez on 16/12/21.
//

import Foundation
import UIKit
import RealmSwift

class Cache {
    
    static let shared = Cache()
    
    private var realm: Realm {
        do {
            let realm = try Realm()
            
            return realm
        } catch {
            print("Could not access database.")
        }
        
        return self.realm
    }
    
    func setCollection(objects: [ContentAdapter], with type: ResourceType, on category: Category) {
        
        let entities = objects.map { item -> ContentEntity in
            let entity = ContentEntity()
            entity.id = item.contentId
            entity.title = item.contentTitle
            entity.overview = item.contentOverview
            entity.image = item.contentImage
            entity.resourceType = type.rawValue
            entity.category = category.rawValue
            return entity
        }
        
        do {
            try realm.write {
                realm.add(entities, update: .modified)
            }
        } catch {
            print("Could not write to database.")
        }
    }
    
    func getCollection(of category: Category, with type: ResourceType) -> [ContentAdapter] {
        let filter = "category = '\(category.rawValue)' AND resourceType = '\(type.rawValue)'"
        let result = realm.objects(ContentEntity.self).filter(filter)
        
        return Array(result)
    }
    
    func search(_ text: String, with type: ResourceType) -> [ContentAdapter] {
        let filter = "resourceType = '\(type.rawValue)' AND title CONTAINS '\(text)'"
        let result = realm.objects(ContentEntity.self).filter(filter)
        
        return Array(result)
    }
}
