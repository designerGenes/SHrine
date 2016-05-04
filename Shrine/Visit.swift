//
//  Visit.swift
//  
//
//  Created by Jaden Nation on 4/28/16.
//
//

import Foundation
import CoreData


class Visit: NSManagedObject {
  // MARK: -- variables
  
  
  
  // MARK: -- custom functions
  func loadProperties(shrine: Shrine, date: NSDate) {
//    self.shrine = shrine
    self.date = date
  }
  
  
  // MARK: -- required functions
  
  
} // end of custom class
