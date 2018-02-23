//
//  YelpClient.swift
//  World Restaurants
//
//  Created by Farzad on 2/8/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
class YelpClient: NetworkApiClient {
 
    static let Shared = YelpClient()
    let session : URLSession
    private init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    private convenience init() {
        self.init(configuration:.default)
    }
    
    func getRestaurantsByGroup(){}
    
    
    func getRestaurants(searchTerm:String ,at coordinate:Coordinate, categories: [RestaurantCategory] = [],radius:Int? = nil, limit: Int = 30,sortType: Yelp.YelpSortType = .rating, complition: @escaping (Result<[Restaurant],APIError>) -> ()){
        
      
        let endpoint = Yelp.search(term: searchTerm, coordinate: coordinate, radius: radius, categories: categories, limit: limit, sortBy: sortType)
        
        let request = endpoint.requestWithAuthorizationHeader()
        
        fetch(with: request, parse: { json -> [Restaurant] in
            guard let restaurants = json["businesses"] as? [[String: Any]] else { return []}
            return restaurants.flatMap { Restaurant(json:$0)}
        }, complition: complition)
        
    }
    
    func getRestaurantDetail(restaurantId:String,compilition: @escaping (Result<Restaurant,APIError>) -> ()) {
        let endpoint = Yelp.business(id: restaurantId)
        let request = endpoint.requestWithAuthorizationHeader()
        
        fetch(with: request, parse: { json -> Restaurant? in
           
            return Restaurant(json: json)
        }, complition: compilition)
    }
    
    
    func updateWithHoursandPhotos(restaurant: Restaurant,compilition: @escaping (Result<Restaurant,APIError>) -> ()){
        let endpoint = Yelp.business(id: restaurant.id)
        let request = endpoint.requestWithAuthorizationHeader()
        
        fetch(with: request, parse: { json -> Restaurant? in
            restaurant.updateWithHoursAndPhotos(json: json)
            return restaurant
        }, complition: compilition)
        
    }
    
    
    func downloadImage(from urlString:String,compilition: @escaping (Result<Photo,APIError>) -> ()) {
        let url = URL(string: urlString)
        download(with: url!, parse: { (data) -> Photo? in
            return Photo(data: data)
        }, complition: compilition)
    }
    
    
}
