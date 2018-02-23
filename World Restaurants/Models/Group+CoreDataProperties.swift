//
//  Group+CoreDataProperties.swift
//  World Restaurants
//
//  Created by Farzad on 2/10/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//
//

import Foundation
import CoreData


extension Group {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Group> {
        return NSFetchRequest<Group>(entityName: "Group")
    }

    @NSManaged public var name: String?
    @NSManaged public var favoritesrestaurants: FavoriteRestaurants?

}
