//
//  LocationManager.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol UserLocationManagerDelegate : AnyObject {
    func  locationUpdated(coordinate:Coordinate)
}

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var userAuthorizationStatus:CLAuthorizationStatus?
    weak var delegate:UserLocationManagerDelegate?
    var userLocationCoordinate:Coordinate?
    weak var viewController:UIViewController?
    static let Shared = UserLocationManager()
     override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
      // manager.requestLocation()
    }
    func requestLocationAuthorization() throws {
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        if authorizationStatus == .authorizedWhenInUse {
            
            return
            
        }else if authorizationStatus == .restricted || authorizationStatus == .denied {
           throw LocationError.disallowed
        } else if authorizationStatus == .notDetermined {
           
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
       self.userAuthorizationStatus = status
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let viewController = viewController else {
            return
        }
       alert(view: viewController, title: "Location Access Failure", message: "App could not access locations. Loation services may be unavailable or are turned off. Error code: \(error)")
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var coordinate:Coordinate?
        if let location = locations.last  {
              coordinate = Coordinate(location: location)
        }
      print(locations.count)
        self.userLocationCoordinate = coordinate
       delegate?.locationUpdated(coordinate: coordinate!)
       
    }
    
    
}





