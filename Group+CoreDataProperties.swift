//
//  Group+CoreDataProperties.swift
//  
//
//  Created by Farzad on 2/12/18.
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
