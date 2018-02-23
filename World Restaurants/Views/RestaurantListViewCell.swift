//
//  RestaurantListViewCell.swift
//  World Restaurants
//
//  Created by Farzad on 2/13/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class RestaurantListViewCell: UITableViewCell {

    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantdistance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
