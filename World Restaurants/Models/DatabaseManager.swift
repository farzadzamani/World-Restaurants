//
//  Database.swift
//  World Restaurants
//
//  Created by Farzad on 2/12/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    let shared = DatabaseManager()
    let context = CoreDataStack.Shared.managedObjectContext
    private init(){}
    
//    func getAllGroupCountry(){
//        let fetchRequest:NSFetchRequest<Group> = Group.fetchRequest()
//        fetchRequest.sortDescriptors = []
//        if let result = try? context.fetch(fetchRequest) {
//            return result
//        }
//        
//    }
}
