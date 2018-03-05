//
//  FavoriteRestaurantsExtention.swift
//  World Restaurants
//
//  Created by Farzad on 2/12/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import CoreData
extension SavedRestaurant {
    
    convenience init(restaurant:Restaurant,countryGroup:CountryGroup,context:NSManagedObjectContext) {
        self.init(context: context)
        self.restaurantId = restaurant.id
        self.name = restaurant.name
        self.countryGroup = countryGroup.name
        
    }

    
    }
