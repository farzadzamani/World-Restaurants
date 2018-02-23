//
//  FavoriteRestaurants+CoreDataProperties.swift
//  
//
//  Created by Farzad on 2/12/18.
//
//

import Foundation
import CoreData


extension FavoriteRestaurants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteRestaurants> {
        return NSFetchRequest<FavoriteRestaurants>(entityName: "FavoriteRestaurants")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var group: Group?

}
