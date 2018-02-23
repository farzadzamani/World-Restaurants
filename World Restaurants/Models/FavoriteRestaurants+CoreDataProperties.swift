//
//  FavoriteRestaurants+CoreDataProperties.swift
//  World Restaurants
//
//  Created by Farzad on 2/10/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
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
