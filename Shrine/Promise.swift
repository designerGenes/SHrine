//
//  Promise.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData
// worry about coredata later


class Promise: NSManagedObject {
  // MARK: -- variables
//  var locationNickname: String?
//  var assocShrine: Shrine?
//  var reasonWhy: String?
//  var penaltyIfChainBroken: String?  // change this later
//  var rewardInterval: Int?
//  
  
  // MARK: -- custom functions
  func doWasCreated() {
    
  }
  
  func lastVisit() -> NSDate? {
    return nil
  }
  
  func daysSinceLastVisit() -> Int? {
    return nil
  }
  
  func setValues(interval: Int, _ reward: String, _ punishment: String) {
    self.interval = interval ; self.reward = reward ; self.punishment = punishment
  }
  
  
  // MARK: -- required functions
  
//  init(nickname: String, assocShrine: Shrine) {
////    self.locationNickname = nickname ; self.assocShrine = assocShrine
////    super.init()
//    
////    doWasCreated()
//  }
  
} // end of custom class