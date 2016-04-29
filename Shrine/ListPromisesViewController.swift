//
//  ListPostsViewController.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import ChameleonFramework
import SwiftHEXColors
import CoreData

class ListPromisesViewController: BetterViewController {
  // MARK: -- outlets
  @IBOutlet weak var btnCancel: UIButton!
  @IBOutlet weak var tblPromises: UITableView!
  @IBAction func unwindToList(segue: UIStoryboardSegue) {}
  
  // MARK: -- variables
  
  
  // MARK: -- custom functions
  func didLoadStuff() {
    model = ListPromises_Model(master: self)
    SAFECAST(model, type: ListPromises_Model.self) { model in
      self.tblPromises.dataSource = model ; self.tblPromises.delegate = model
    }
  }
  
  func willAppearStuff() {
    
  }
  
  func didAppearStuff() {
//    btnCancel.layer.cornerRadius = btnCancel.frame.width / 2
    
  }
  
  // MARK: -- segue functions
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == Segue.fromListToDetail.rawValue {
      if let id = sender as? NSManagedObjectID {
        if let dest = segue.destinationViewController as? PromiseDetailViewController {
          dest.focusID = id
        }
      }
    }
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
