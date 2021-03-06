//
//  YelpEndpoint.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation

protocol YelpEndpoint {
  
    var base: String { get }
   
    var path: String { get }
    
    var queryItems: [URLQueryItem] { get }
}

extension YelpEndpoint {
    
    
    
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        
        components.queryItems = queryItems
        
        return components
    }
    
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
  
    func requestWithAuthorizationHeader() -> URLRequest {
        var authrequest = request
        let APIKEY = "8w3G0xly-Z87DGOPkDkwsn2AfK1Q5HmNKuZj0AvRmBSrA5_XyDL14NpCL7Mbi9gLVLcaY-EhtokE7JPJEqz8cPUZrRAMoPmQz8e9Uz9Au2a3lTI3M0q7hXeLnw10WnYx"
        authrequest.addValue("bearer \(APIKEY)", forHTTPHeaderField: "Authorization")
        return authrequest
    }
}

enum Yelp {
    enum YelpSortType: CustomStringConvertible {
        case bestMatch, rating, reviewCount, distance
        
        var description: String {
            switch self {
            case .bestMatch: return "best_match"
            case .rating: return "rating"
            case .reviewCount: return "review_count"
            case .distance: return "distance"
            }
        }
    }
    
    case search(term: String, coordinate: Coordinate, radius: Int?, categories: [RestaurantCategory], limit: Int?, sortBy: YelpSortType?)
    case business(id: String)
    
}

extension Yelp: YelpEndpoint {
    var base: String {
        return "https://api.yelp.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/v3/businesses/search"
        case .business(let id): return "/v3/businesses/\(id)"
       
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term, let coordinate, let radius, let categories, let limit, let sortBy):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "latitude", value: coordinate.latitude.description),
                URLQueryItem(name: "longitude", value: coordinate.longitude.description),
                URLQueryItem(name: "radius", value: radius?.description),
                URLQueryItem(name: "categories", value: categories.map({$0.alias}).joined(separator: ",")),
                URLQueryItem(name: "limit", value: limit?.description),
                URLQueryItem(name: "sort_by", value: sortBy?.description)
            ]
        case .business: return []
       
        }
    }
}
