//
//  Shrine+CoreDataProperties.swift
//  
//
//  Created by Jaden Nation on 4/29/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Shrine {

    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var nickname: String?
    @NSManaged var originCity: String?
    @NSManaged var promise: Promise?
    @NSManaged var visits: NSSet?

}
