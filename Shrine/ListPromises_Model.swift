//
//  ListPromises_Model.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit
import CoreData
// import SwiftOverlays or whatever


class ListPromises_Model: ViewModel, UITableViewDelegate, UITableViewDataSource {
  
  
  // MARK: -- variables
  var assocTableView: UITableView!
  var promisesList = [Promise]()
  
  // MARK: -- custom functions
  func doWasCreated() {
    SAFECAST(master, type: ListPromisesViewController.self) { master in
      self.assocTableView = master.tblPromises
      self.doRetrievePromises()
    
    }
  }
  
  func doRetrievePromises() {
    let CD = getAppDelegate().CoreData_Brain
    if let promises = CD.resultsOfRequest(getAppDelegate().CoreData_Brain.promiseDescription) as? [Promise] {
      print("Generated array of \(promises.count) Promises")
      self.promisesList = promises
      reloadTable()
    } else {
      print("ERROR: Could not generate list of Promises")
    }
  }
  
  
  // MARK: -- tableView functions
  func reloadTable() {
    SAFECAST(master, type: ListPromisesViewController.self) { master in
      // things here before reloading the table
      master.tblPromises.reloadData()
      
    }
  }
  
  func configureCell(cell: PromiseTableViewCell, index: Int) -> PromiseTableViewCell {
    SAFECAST(master, type: ListPromisesViewController.self) { master in
      SAFE(self.promisesList[index]) { promise in
      SAFE(promise.shrine) { shrine in
        cell.lblShrineNickname.text = shrine.nickname!
        cell.id = promise.objectID
        cell.btnPromiseHealthIndicator.setImage(self.setHealthIndicator(index), forState: .Normal)
      }
      }
  }
    return cell
  }
  
  func didSelectRowAt(index: Int) {
    let id = self.promisesList[index].objectID
    master.performSegueWithIdentifier(.fromListToDetail, sender: id )
    
  }
  
  func setHealthIndicator(cellIndex: Int) -> UIImage {
    return UIImage(named: "imgHealthy")!  // come back to this
  }
  
  
  // MARK: -- tableView delegate functions
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    didSelectRowAt(indexPath.row)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return promisesList.count // for now...
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1 // for now...
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell = PromiseTableViewCell()
    SAFECAST(master, type: ListPromisesViewController.self) { master in
      cell = master.tblPromises.dequeueReusableCellWithIdentifier(CustomCellID.CellPromise.rawValue, forIndexPath: indexPath) as! PromiseTableViewCell
      cell = self.configureCell(cell, index: indexPath.row)
    }
    return cell
  }
  
  
  // MARK: -- required functions
  init(master: ListPromisesViewController) { super.init(_master: master) ; doWasCreated() }
  
} // end of model class