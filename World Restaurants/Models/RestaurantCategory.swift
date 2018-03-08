//
//  YelpCategory.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation

struct RestaurantCategory {
    let alias: String
    let title: String
}

extension RestaurantCategory: JSONDecodable {
    init?(json: [String : Any]) {
        guard let aliasValue = json["alias"] as? String, let titleValue = json["title"] as? String else { return nil }
        self.alias = aliasValue
        self.title = titleValue
    }
}
