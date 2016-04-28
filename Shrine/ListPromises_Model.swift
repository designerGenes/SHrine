//
//  ListPromises_Model.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit

class ListPromises_Model: ViewModel {
  // MARK: -- variables
  
  
  // MARK: -- custom functions
  func doWasCreated() {
    
  }
  
  
  // MARK: -- required functions
  init(master: ListPromisesViewController) { super.init(_master: master) ; doWasCreated() }
  
} // end of model class