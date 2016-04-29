//
//  Shrine+CoreDataProperties.swift
//  
//
//  Created by Jaden Nation on 4/28/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Shrine {

    @NSManaged var nickname: String?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var assocPromise: NSManagedObject?
    @NSManaged var visit: NSManagedObject?

}
