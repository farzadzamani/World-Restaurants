//
//  ReviewCell.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    static let reuseIdentifier = "ReviewCell"
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with viewModel: ReviewCellViewModel) {
        reviewLabel.text = viewModel.review
        userImageView.image = viewModel.userImage
    }
    
}

