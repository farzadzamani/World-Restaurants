//
//  RestaurantPhotos.swift
//  World Restaurants
//
//  Created by Farzad on 2/11/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit

struct Photo {
    var image:UIImage
    
    init?(data: Data) {
        self.image = UIImage(data: data) ?? #imageLiteral(resourceName: "placeholder")
    }
    
    
    
}
