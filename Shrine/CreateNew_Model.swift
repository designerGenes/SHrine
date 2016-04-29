//
//  CreateNew_Model.swift
//  Shrine
//
//  Created by Jaden Nation on 4/27/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit


class CreateNew_Model: ViewModel {
  // MARK: -- variables


  // MARK: -- custom functions
  func doCreateNewDataObjects() {
    
  }
  
  
  func doWasCreated() {
    
  }


  // MARK: -- required functions
  init(master: CreateNewPromiseViewController) { super.init(_master: master) ; doWasCreated() }

} // end of model class