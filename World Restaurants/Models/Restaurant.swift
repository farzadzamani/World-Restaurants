//
//  Restaurant.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation

class Restaurant: NSObject, JSONDecodable {
    let id: String
    let country: Country?
    let name: String
    let imageUrl: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [RestaurantCategory]
    let rating: Double
    let location: Coordinate
    let transactions: [RestaurantTransaction]
    let address: Address
    let phone: String
    let displayPhone: String
    let price: String
    
   
    var distance: Double?
    
  
    var photos: [String]
    var hours: BusinessHours?
   
    
    required init?(json: [String : Any]) {
        guard let id = json["id"] as? String,
            let name = json["name"] as? String,
            let imageUrl = json["image_url"] as? String,
            let isClosed = json["is_closed"] as? Bool,
            let url = json["url"] as? String,
            let reviewCount = json["review_count"] as? Int,
            let categoriesDict = json["categories"] as? [[String: Any]],
            let rating = json["rating"] as? Double,
            let coordinatesDict = json["coordinates"] as? [String: Any],
            let coordinates = Coordinate(json: coordinatesDict),
            let transactionValues = json["transactions"] as? [String],
            let location = json["location"] as? [String: Any],
            let address = Address(json: location),
            let price = json["price"] as? String,
            let phone = json["phone"] as? String,
            let displayPhone = json["display_phone"] as? String
            else { return nil }
        
        self.id = id
        self.country = Country(country: "all", countryGroup: .african)
        self.name = name
        self.imageUrl = imageUrl
        self.isClosed = isClosed
        self.url = url
        self.reviewCount = reviewCount
        self.categories = categoriesDict.flatMap { RestaurantCategory(json: $0) }
        self.rating = rating
        self.location = coordinates
        self.transactions = transactionValues.flatMap { RestaurantTransaction(rawValue: $0) }
        self.address = address
        self.phone = phone
        self.displayPhone = displayPhone
        self.price = price
        
        self.distance = json["distance"] as? Double
        self.photos = json["photos"] as? [String] ?? []
        
        if let hours = json["hours"] as? [[String: Any]], let dict = hours.first {
            self.hours = BusinessHours(json: dict)
        }
        
       
        
        super.init()
    }
    
    func updateWithHoursAndPhotos(json: [String: Any]) {
        if let photoStrings = json["photos"] as? [String] {
            photos = photoStrings
        }
        
        if let hours = json["hours"] as? [[String: Any]], let dict = hours.first {
            self.hours = BusinessHours(json: dict)
        }
    }
}

