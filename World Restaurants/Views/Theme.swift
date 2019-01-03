//
//  appTheme.swift
//  World Restaurants
//
//  Created by Farzad on 11/23/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import UIKit

public enum Theme {
    case listItemBackground
    
    
}

extension Theme {
    var color:UIColor {
        switch self {
        case .listItemBackground: return UIColor(red: 255, green: 229, blue: 223)
        
            
        }
    }
}
