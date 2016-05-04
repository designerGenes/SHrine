//
//  Help_Model.swift
//  Shrine
//
//  Created by Jaden Nation on 5/2/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit

class Help_Model: ViewModel {
  // MARK: -- variables
  
  
  // MARK: -- custom functions
  func doWasCreated() {
    
  }
  
  
  // MARK: -- required functions
  init(master: HelpViewController) { super.init(_master: master) ; doWasCreated() }
  
} // end of model class