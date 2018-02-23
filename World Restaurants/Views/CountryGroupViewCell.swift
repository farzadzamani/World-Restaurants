//
//  CountryGroupViewCell.swift
//  World Restaurants
//
//  Created by Farzad on 2/12/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class CountryGroupViewCell: UITableViewCell {


    @IBOutlet weak var ContentView: UIView!

    
    @IBOutlet weak var groupImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
