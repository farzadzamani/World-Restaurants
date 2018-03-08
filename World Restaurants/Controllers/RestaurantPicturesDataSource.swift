//
//  RestaurantPicturesDataSource.swift
//  World Restaurants
//
//  Created by Farzad on 2/9/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit
class RestaurantPicturesDataSource: NSObject,UICollectionViewDataSource  {
    
     private var data = [String]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as! pictureCollectionViewCell
        let restaurantPhotoUrl = data[indexPath.row]
        
        cell.restaurantPicture.FromString(from: restaurantPhotoUrl)
        cell.restaurantPicture.RoundedView()
        
        return cell
        
        
        
    }
    
    func update(with data: [String]) {
        self.data = data
    }
    
    
}
