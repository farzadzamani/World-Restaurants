//
//  JSONDecodable.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation

protocol JSONDecodable {
 
    init?(json: [String: Any])
}
