//
//  SettingsViewController.swift
//  Shrine
//
//  Created by Jaden Nation on 5/2/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit

class SettingsViewController: BetterViewController {
  // MARK: -- outlets
  
  
  // MARK: -- variables
  
  
  // MARK: -- custom functions
  func didLoadStuff() {
    model = Settings_Model(master: self)
  }
  
  func willAppearStuff() {
    
  }
  
  func didAppearStuff() {
    
  }
  
  // MARK: -- required functions
  override func viewDidLoad() {
    super.viewDidLoad()
    didLoadStuff()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    didAppearStuff()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    willAppearStuff()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
} // end of class