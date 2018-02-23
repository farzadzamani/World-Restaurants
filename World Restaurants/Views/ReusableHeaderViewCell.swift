//
//  ReusableHeaderViewCellTableViewCell.swift
//  World Restaurants
//
//  Created by Farzad on 2/13/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class ReusableHeaderViewCell: UITableViewCell {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
