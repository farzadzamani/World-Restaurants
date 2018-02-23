//
//  RestaurantDetailViewModel.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
struct RestaurantDetailViewModel {
    let restaurantName: String
    let price: String
    let rating: Double
    let ratingsCount: String
    let categories: String
    let hours: String?
    let currentStatus: String
}

extension RestaurantDetailViewModel {
    init?(restaurant: Restaurant) {
        self.restaurantName = restaurant.name
        self.price = restaurant.price
        self.rating = restaurant.rating
        self.ratingsCount = "(\(restaurant.reviewCount.description))"
        
        self.categories = restaurant.categories.map({ $0.title }).joined(separator: ", ")
        
        guard let hours = restaurant.hours else { return nil }
        
        for day in hours.schedule {
            print(day.day)
        }
        
        let currentDayValue = Date.currentDay
//    print("Current Day: \(currentDayValue)")
        if let today = hours.schedule.filter({ $0.day.rawValue == Date.currentDay }).first {
        
        let startString = DateFormatter.stringFromDateString(today.start, withInputDateFormat: "HHmm")
        let endString = DateFormatter.stringFromDateString(today.end, withInputDateFormat: "HHmm")
        
        
            self.hours = "Hours Today: \(startString) - \(endString)" }else { self.hours = "Hours Today: Is Not available"}
        self.currentStatus = !restaurant.isClosed ? "Open" : "Closed"
    }
}

extension DateFormatter {
    static func stringFromDateString(_ inputString: String, withInputDateFormat format: String) -> String {
        let formatter = DateFormatter()
        let locale = Locale.current
        formatter.locale = locale
        
        formatter.dateFormat = format
        
        let date = formatter.date(from: inputString)!
        
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
}

extension Date {
    static var currentDay: Int {
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: date)
        
        let day = components.day! % 7
        
        return day
    }
}
