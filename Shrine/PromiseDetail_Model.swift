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
import CoreLocation
import SwiftMoment

class PromiseDetail_Model: ViewModel {
  // MARK: -- variables
  var cells = [FormCell]()
  var focus: Promise?
  
  // MARK: -- custom functions
  func doWasCreated() {
    
  }
  
  func doVerifyDeletionRequest() {
    let verifyDeletion = BetterAlert(title: "Are you sure?", message: STR_VerifyDeletionRequest, hasCancel: true, vc: self.master, cancelAction: { 
      //
      }) { // ok action
        let context = getAppDelegate().CoreData_Brain.managedObjectContext
        SAFE(self.focus) { context.deleteObject($0) }
        SAFECAST(self.master, type: PromiseDetailViewController.self) { master in
          master.performSegueWithIdentifier(Segue.unwind_DetailToList.rawValue, sender: self)
        }
        
    }
  }
  
  func generateFormerCells() {
    PF("generateFormerCells")
    SAFECAST(master, type: PromiseDetailViewController.self) { master in
    SAFE(self.focus) { promise in
    SAFE(promise.shrine) { shrine in
      let former = master.former
      
      // NOTE: IN PROGRESS
      //
      // TO ADD:
      // I AM HERE button row
      // OPEN IN MAPS button row
      
      // SECTIONS:
      //  idSection
      //  buttonSection
      //  rewardSection
      //  punishmentSection
      //  healthSection
      
      //  configure chain box
      let chainBox = master.viewContainsChain
      if let color = UIColor(hexString: promise.colorShorthand!) {
        chainBox.backgroundColor = color.darkenByPercentage(0.2)
        master.viewTopZone.backgroundColor = color

        master.viewContainsTableAndChain.backgroundColor = colors[projColor.gray_accent.rawValue]!
        master.viewContainsChain.backgroundColor = colors[projColor.gray_accent.rawValue]!.darkenByPercentage(0.15)
        master.viewBottomZone.backgroundColor = color
        master.lblShrineNickname.text = shrine.nickname!
      }
      
      
      //  ID SECTION
      let idHeader = LabelViewFormer<FormLabelHeaderView>().configure { view in
        let dateCreated = moment(promise.dateCreated!)
        let today = moment(NSDate(timeIntervalSinceNow: 0))
        view.text = "\(dateCreated.month)/\(dateCreated.day)/\(dateCreated.year) to \(today.month)/\(today.day)/\(today.year)"
        view.viewHeight = 40
        
      }
      
      let cityOriginRow = LabelRowFormer<FormLabelCell>().configure { row in
        let originCoord = CLLocationCoordinate2D(latitude: Double(shrine.latitude!), longitude: Double(shrine.longitude!))
        row.text = "\(shrine.originCity!)"
        
        }.cellSetup { cell in
          
      }
      
      
      let intervalRow = LabelRowFormer<FormLabelCell>().configure { row in
        row.text = "I promise to return every \(promise.interval!) days"
        }.cellSetup { cell in
          cell.textLabel?.lineBreakMode = .ByWordWrapping
          cell.textLabel?.numberOfLines = 0
          cell.sizeToFit()
      
      }
      
      let idSection = SectionFormer(rowFormers: [cityOriginRow, intervalRow])
      idSection.set(headerViewFormer: idHeader)
      
      //  BUTTON SECTION
      
      
  
      
      //  REWARD SECTION
      let rewardHeader = LabelViewFormer<FormLabelHeaderView>().configure { view in
        view.text = "Reward"
      }
      
      let rewardRow = LabelRowFormer<FormLabelCell>().configure { row in
        row.text = STR_Consequences[promise.reward!]!
        }.cellSetup { cell in
          cell.textLabel?.lineBreakMode = .ByWordWrapping
          cell.textLabel?.numberOfLines = 0
          cell.sizeToFit()
      }
      
      let rewardSection = SectionFormer(rowFormer: rewardRow)
      rewardSection.set(headerViewFormer: rewardHeader)
      
      //  PUNISHMENT SECTION
      let punishmentHeader = LabelViewFormer<FormLabelHeaderView>().configure { view in
        view.text = "Punishment"
      }
      
      let punishmentRow = LabelRowFormer<FormLabelCell>().configure { row in
        row.text = STR_Consequences[promise.punishment!]!
        }.cellSetup { cell in
          cell.textLabel?.lineBreakMode = .ByWordWrapping
          cell.textLabel?.numberOfLines = 0
          cell.sizeToFit()
      }
      let punishmentSection = SectionFormer(rowFormer: punishmentRow)
      punishmentSection.set(headerViewFormer: punishmentHeader)
      
      //  HEALTH SECTION
      let healthHeader = LabelViewFormer<FormLabelHeaderView>().configure { view in
        view.text = "Health"
      }
      
      let healthBarRow = LabelRowFormer<FormLabelCell>().configure { row in
        row.text = "Health: ( health )"
        }.cellSetup { cell in
          
      }
      
      
      let healthSection = SectionFormer(rowFormers: [healthBarRow])
      healthSection.set(headerViewFormer: healthHeader)
      
      
      
      former.add(sectionFormers: [idSection, rewardSection, punishmentSection, healthSection])
    
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
