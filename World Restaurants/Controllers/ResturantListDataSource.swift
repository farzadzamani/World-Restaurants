//
//  ResturantListDataSource.swift
//  World Restaurants
//
//  Created by Farzad on 2/1/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import CoreLocation

class ResturantListDataSource: NSObject, UITableViewDataSource{

    private var data = [Restaurant]()
    var countryGroup:CountryGroup?
    override init() {
        super.init()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableRestaurantList", for: indexPath) as! RestaurantListViewCell
        
        let restaurant = object(at: indexPath)
        if let myLocation = UserLocationManager.Shared.userLocationCoordinate {
            let myCoordinate = CLLocation(latitude: myLocation.latitude,longitude: myLocation.longitude)
            let distance = CLLocation(latitude: restaurant.location.latitude,longitude: restaurant.location.longitude).distance(from: myCoordinate)

           cell.restaurantdistance.text = "~ \(String(format:"%.2f",distance / 1609.34 )) mi"
        }
        
        cell.restaurantName.text = restaurant.name
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "\(countryGroup?.name ?? "All") Restaurants "
        default: return nil
        }
    
    }
    
    // MARK: Helpers
    
    func object(at indexPath: IndexPath) -> Restaurant {
        return data[indexPath.row]
    }
    
    func update(with data: [Restaurant],countryGroup:CountryGroup?) {
        self.data = data.sorted {
        $0.distance! < $1.distance!
        }
        self.countryGroup = countryGroup
    }
    
    
    
}

