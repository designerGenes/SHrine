//
//  PromiseDetailViewController.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/26/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import CoreData
import Former

class PromiseDetailViewController: BetterViewController {
  // MARK: -- outlets
  
  @IBOutlet weak var tblPromiseDetails: UITableView!
  @IBOutlet weak var viewContainsChain: UIView!
  
  // MARK: -- variables
  var focusID: NSManagedObjectID!
  var former: Former!
  
  // MARK: -- custom functions
  func didLoadStuff() {
    former = Former(tableView: tblPromiseDetails)
    model = PromiseDetail_Model(master: self, id: focusID)
    
//    SAFECAST(model, type: PromiseDetail_Model.self) { $0.generateFormerCells(self.former) }  // put "wait" function here instead
  }
  
  func willAppearStuff() {
    
  }
  
  func didAppearStuff() {
//    SAFE(focusID) { id in
//      self.lblID.text = String(id)
//    }
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
