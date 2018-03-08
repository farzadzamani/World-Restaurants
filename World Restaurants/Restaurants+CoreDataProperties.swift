//
//  Restaurants+CoreDataProperties.swift
//  
//
//  Created by Farzad on 2/10/18.
//
//

import Foundation
import CoreData


extension Restaurants {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurants> {
        return NSFetchRequest<Restaurants>(entityName: "Restaurants")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var countryGroup: CountryGroup?

}
