//
//  restaurantPin.swift
//  World Restaurants
//
//  Created by Farzad on 2/14/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//


import MapKit
class Annotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var restaurantId:String?
    var subtitle: String?
    
    init(coordinate: Coordinate, title: String , subtitle:String? ,restaurantId:String?) {
        self.coordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        self.title = title
        self.restaurantId = restaurantId
        self.subtitle = subtitle
    }
    
}
