//
//  ReviewCellViewModel.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit

struct ReviewCellViewModel {
    let review: String
    let userImage: UIImage
}

extension ReviewCellViewModel {
    init(review: RestaurantReview) {
        self.review = review.text
        self.userImage = review.user.image ?? #imageLiteral(resourceName: "placeholder")
    }
}

