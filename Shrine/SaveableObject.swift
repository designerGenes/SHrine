//
//  SaveableObject.swift
//  Shrine
//
//  Created by Jaden Nation on 4/28/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import CoreData

class SaveableObject: NSObject {
  // MARK: -- variables
  var tableName: String?
  
  
  
  // MARK: -- custom functions
  func saveToRecord<T>(type: T) {
    if let managedObj = type as? NSManagedObject {
      
    }
  }
  
  
  // MARK: -- required functions
  
  
} // end of custom class
