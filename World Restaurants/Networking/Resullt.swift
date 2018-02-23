//
//  Resullt.swift
//  World Restaurants
//
//  Created by Farzad on 2/7/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
enum Result<T, E> where E: Error {
    case success(T)
    case failure(E)
}
