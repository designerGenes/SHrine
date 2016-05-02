//
//  CreateNew_Model.swift
//  Shrine
//
//  Created by Jaden Nation on 4/27/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation



class CreateNew_Model: ViewModel, CLLocationManagerDelegate {
  // MARK: -- variables
  var promise: Promise? ; var shrine: Shrine?; var visit: Visit?
  var LM: CLLocationManager = CLLocationManager()

  // MARK: -- custom functions
  func doCreateNewDataObjects() {
    PF("doCreateNewDataObjects")
    SAFECAST(master, type: CreateNewPromiseViewController.self) { master in
      SAFE(master.shrineTitle) { title in
      SAFE(master.selectedInterval) { interval in
      SAFE(master.selectedReward) { reward in
      SAFE(master.selectedPunishment) { punishment in
        print("Got past a lot of guff")
        if (CLLocationManager.authorizationStatus() == .AuthorizedAlways) || (CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse) { } // expand
        master.view.blur(1, style: .Dark)
        
        // step 1: create Promise object in saveable form
        self.promise = Promise(entity: getAppDelegate().CoreData_Brain.promiseDescription, insertIntoManagedObjectContext: getAppDelegate().CoreData_Brain.managedObjectContext)
        SAFE(self.promise) { promise in  // set Promise properties
          promise.colorShorthand = master.shrineColor
          promise.dateCreated = NSDate(timeIntervalSinceNow: 0)
          promise.setValues(interval, reward.rawValue, punishment.rawValue)
        }
  
        self.LM.startUpdatingLocation()  ; self.LM.requestLocation()
        
      } } } }
      // // // //
    }
    
  }
  
  func doSaveDataObjects() {
    PF("doSaveDataObjects")
    SAFECAST(master, type: CreateNewPromiseViewController.self) { master in
    SAFE(self.promise) { promise in
    SAFE(self.shrine) { shrine in
    SAFE(self.visit) { visit in
      print("Object is wholesome and ready to save")
      do {
        try promise.managedObjectContext?.save()
        try shrine.managedObjectContext?.save()
        try visit.managedObjectContext?.save()
        print("Successfully saved objects!")
        master.performSegueWithIdentifier(.unwind_CreateToMain, sender: self)
      } catch {
        print("Unable to save these objects")
      }
      
      
    } } } }
    // // // //
    self.master.view.unBlur()
  }
  
  
  func doWasCreated() {
    LM.delegate = self
  }
  
  // MARK: -- CLLocationManager Delegate functions
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("Here is an error: \(error.localizedDescription)")
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("Updated location")
    SAFECAST(master, type: CreateNewPromiseViewController.self) { master in
    SAFE(locations.first) { location in
      SAFE(self.promise) { promise in
        // step 1.1: create Shrine object in saveable form
        self.shrine = Shrine(entity: getAppDelegate().CoreData_Brain.shrineDescription, insertIntoManagedObjectContext: getAppDelegate().CoreData_Brain.managedObjectContext)
        SAFE(self.shrine) { shrine in
          let geoCoder = CLGeocoder()
          shrine.latitude = location.coordinate.latitude
          shrine.longitude = location.coordinate.longitude
          shrine.nickname = master.shrineTitle!
          geoCoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void  in
            SAFE(placemarks?.first)  { place in
              if let city = place.addressDictionary!["City"] as? String {
                if let country = place.addressDictionary!["Country"] as? String {
                  shrine.originCity = "\(city), \(country)"
                }
              }
            }
            
            // step 1.2: create initial Visit object and attach to shrine
              let visit = Visit(entity: getAppDelegate().CoreData_Brain.visitDescription, insertIntoManagedObjectContext: getAppDelegate().CoreData_Brain.managedObjectContext)
              self.visit = visit
              visit.date = NSDate(timeIntervalSinceNow: 0)
              
            // step 1.3: tie them all together
              visit.setValue(shrine, forKey: "shrine")
              shrine.promise = promise
              promise.shrine = shrine
    //          visit.shrine = shrine
              
            // step 1.4: move onwards and upwards
              self.doSaveDataObjects()
            }
          }
        }
        }
//        manager.stopUpdatingLocation()
    }
  }
  


  // MARK: -- required functions
  init(master: CreateNewPromiseViewController) { super.init(_master: master) ; doWasCreated() }

} // end of model class