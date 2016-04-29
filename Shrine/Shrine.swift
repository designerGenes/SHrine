//
//  Shrine.swift
//  Shrine
//
//  Created by Jaden Nation on 4/28/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

class Shrine: NSManagedObject {
  // MARK: -- variables
  
  
  
  // MARK: -- custom functions
  func setValues(nickname: String, coord: CLLocationCoordinate2D) {
    self.nickname = nickname
    self.latitude = coord.latitude ; self.longitude = coord.longitude
  }
  
  func addVisit() { // return to this
    if let visits = self.visits as? [Visit] {
      
    }
  }
  
  
  // MARK: -- required functions
  
  
} // end of custom class