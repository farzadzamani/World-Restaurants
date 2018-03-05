//
//  Error.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation


enum LocationError: Error {
    case disallowed
    case unableToFindLocation
    case uknownError
    case unableToGetCoordinate
    
}
