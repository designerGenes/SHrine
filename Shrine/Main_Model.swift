//
//  Main_Model.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/24/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class Main_Model: ViewModel {
  // MARK: -- variables
    

  // MARK: -- createNPView functions
  func doCreateNewPromise() {
    if let master = master as? MainViewController {
      master.performSegueWithIdentifier(Segue.fromMainToCreate.rawValue, sender: nil)
    }
  }
  
  
  // MARK: -- custom functions
  func doViewAppeared() {  // hacky
    print("Appeared")
    SAFE(getAppDelegate().GPS_Brain) { brain in
      brain.pinColor = UIColor.flatRedColor()
      
//      brain.getCurrentLocation()
      if let master = self.master as? MainViewController { brain.focus = master.mapView }
    }
  }
  
  
  func doWasCreated() {
    if let master = self.master as? MainViewController {
      let brain = getAppDelegate().GPS_Brain
      let mapView = master.mapView
      mapView.userTrackingMode = .Follow
      mapView.alpha = 0
      mapView.clipsToBounds = true
      mapView.delegate = brain
      brain.focus = mapView
      brain.pinColor = UIColor.flatRedColor()
      brain.getCurrentLocation()
      brain.dropPin()
      
      
//        mapView.frame = master.view.frame
//        mapView.center = master.view.center
//        mapView.userInteractionEnabled = false
    }
  }
  



  // MARK: -- required functions
  init(master: MainViewController) { super.init(_master: master) ; doWasCreated() }
  
} // end of model class
