//
//  Promise+CoreDataProperties.swift
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

extension Promise {

    @NSManaged var dateCreated: NSDate?
    @NSManaged var interval: NSNumber?
    @NSManaged var punishment: String?
    @NSManaged var reward: String?
    @NSManaged var shrine: Shrine?
    @NSManaged var colorShorthand: String?
    @NSManaged var intervalsBeforeReward: NSNumber?

}
