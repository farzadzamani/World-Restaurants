//
//  RestaurantReviewsDataSource.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class RestaurantReviewsDataSource:  NSObject, UITableViewDataSource {
    private var data: [RestaurantReview]
    
    init(data: [RestaurantReview]) {
        self.data = data
        super.init()
    }
    
    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier, for: indexPath) as! ReviewCell
        
        let review = object(at: indexPath)
        let viewModel = ReviewCellViewModel(review: review )
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Reviews"
    }
    
    // MARK: Helpers
    
    func update(_ object: RestaurantReview, at indexPath: IndexPath) {
        data[indexPath.row] = object
    }
    
    func updateData(_ data: [RestaurantReview]) {
        self.data = data
    }
    
    func object(at indexPath: IndexPath) -> RestaurantReview {
        return data[indexPath.row]
    }
}

