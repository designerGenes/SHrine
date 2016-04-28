//
//  ListPostsViewController.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import ChameleonFramework

class ListPromisesViewController: BetterViewController {
  // MARK: -- outlets
  @IBOutlet weak var btnCancel: UIButton!
  @IBOutlet weak var tblPosts: UITableView!
  
  
  // MARK: -- variables
  
  
  // MARK: -- custom functions
  func didLoadStuff() {
    model = ListPromises_Model(master: self)
  }
  
  func willAppearStuff() {
    
  }
  
  func didAppearStuff() {
//    btnCancel.layer.cornerRadius = btnCancel.frame.width / 2
    
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
