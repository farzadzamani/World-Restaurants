//
//  Group.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit

enum CountryGroup {
    case medeterian
    case asian
    case african
    case american
    case latinamerica
    case eruopean
    case vegeterian
   
    static let allGroup = [american,medeterian,vegeterian,eruopean,african,latinamerica,asian]
}
extension CountryGroup {
    var name:String {
        switch self {
        case .medeterian: return "Mediterranean"
        case .asian: return "Asian"
        case .african: return "African"
        case .american: return "American"
        case .latinamerica: return "Latin American"
        case .eruopean: return "European"
        case .vegeterian: return "vegeterian"
        
        }
    }
        var image:UIImage {
            switch self {
            case .medeterian: return UIImage(named: "mediSection")!
            case .asian: return UIImage(named: "asianSection")!
            case .african: return UIImage(named: "africanSection")!
            case .american: return UIImage(named: "americanSection")!
            case .latinamerica: return UIImage(named: "mexicanSection")!
            case .eruopean: return UIImage(named: "euroSection")!
           case .vegeterian: return UIImage(named: "vegiSection")!
            }
        var icon:UIImage {
                switch self {
                case .medeterian: return #imageLiteral(resourceName: "medetrianFoodCopy")
                case .asian: return #imageLiteral(resourceName: "asianFood")
                case .african: return #imageLiteral(resourceName: "africanFood")
                case .american: return #imageLiteral(resourceName: "americanFood")
                case .latinamerica: return #imageLiteral(resourceName: "mexicanFood")
                case .eruopean: return #imageLiteral(resourceName: "euroFood")
                case .vegeterian: return #imageLiteral(resourceName: "vegeterian")
            }
       
    }
    var color:UIColor { 
        switch self {
        case .medeterian: return UIColor(red: 49, green: 103, blue:  156)
        case .asian: return UIColor(red: 55, green: 227, blue: 196)
        case .african: return UIColor(red: 63, green: 186, blue: 87)
        case .american: return UIColor(red: 61, green: 227, blue: 165)
        case .latinamerica: return UIColor(red: 51, green: 200, blue: 225)
        case .eruopean: return UIColor(red: 47, green: 228, blue: 223)
         case .vegeterian: return UIColor(red: 47, green: 228, blue: 223)
            
        }
}
}
