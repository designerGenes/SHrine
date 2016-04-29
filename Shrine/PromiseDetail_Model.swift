//
//  PromiseDetail_Model.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/26/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit
import Former
import ChameleonFramework
import CoreData

class PromiseDetail_Model: ViewModel {
  // MARK: -- variables
  var cells = [FormCell]()
  var focus: Promise?
  
  // MARK: -- custom functions
  func doWasCreated() {
    
  }
  
  
  
  func generateFormerCells() {
    PF("generateFormerCells")
    SAFECAST(master, type: PromiseDetailViewController.self) { master in
    SAFE(self.focus) { promise in
    SAFE(promise.shrine) { shrine in
      let former = master.former
      let headerView = LabelViewFormer<FormLabelHeaderView>().configure { view in
        view.text = shrine.nickname!
        view.viewHeight = 40
      }
      
      let createdLabel = LabelRowFormer<FormLabelCell>().configure { row in
        row.text = "Created on \(promise.dateCreated!)"
        }.cellSetup { cell in
          
      }
      let streakLabel = LabelRowFormer<FormLabelCell>().configure { row in
        row.text = "Longest streak: \(self.computeStreak(promise))"
        }.cellSetup { cell in
          
      }
      
      let section = SectionFormer(rowFormers: [createdLabel, streakLabel])
      section.set(headerViewFormer: headerView)
      
      former.append(sectionFormer: section)
    }
    }
    }
  }
  
  func computeStreak(focus: Promise) -> String {
    return " (streak) "
  }
  
  func retrieveFocus(id: NSManagedObjectID, after: ()->()) {
    let CD = getAppDelegate().CoreData_Brain
    if let focusPromise = CD.managedObjectContext.objectWithID(id) as? Promise {
     self.focus = focusPromise
      after()
    }
  }
  
  
  // MARK: -- required functions
  init(master: PromiseDetailViewController, id: NSManagedObjectID) {
    super.init(_master: master) ; doWasCreated()
    retrieveFocus(id, after: generateFormerCells)
  }
  
} // end of model class
