//
//  CoreDataStack.swift
//  World Restaurants
//
//  Created by Farzad on 2/10/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import CoreData
class CoreDataStack {
    
    private init(){}
    
    static var Shared:CoreDataStack = CoreDataStack()
    
    
    lazy var managedObjectContext:NSManagedObjectContext = {
        let container = self.persistentContainer
        return container.viewContext
        
        
    }()
    
    private lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SavedRestaurants")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
}
extension NSManagedObjectContext {
    func saveChanges() -> Error? {
        if self.hasChanges {
            do {
                try save()
                
                
            }catch{
                return error
            }
            
            
        }
        return nil
        
    }
    
}



