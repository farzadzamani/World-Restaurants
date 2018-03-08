//
//  CountryGroup+CoreDataProperties.swift
//  
//
//  Created by Farzad on 2/10/18.
//
//

import Foundation
import CoreData


extension CountryGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryGroup> {
        return NSFetchRequest<CountryGroup>(entityName: "CountryGroup")
    }

    @NSManaged public var name: String?
    @NSManaged public var resturants: Restaurants?

}
