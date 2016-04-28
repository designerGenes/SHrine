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

class Main_Model: ViewModel, CLLocationManagerDelegate {
  // MARK: -- variables
    

  // MARK: -- createNPView functions
  func doCreateNewPromise() {
    SAFECAST(master, type: MainViewController.self) { master in
      if let createNPView = master.loadViewFromNib("CreateNewPromise") as? CreateNewPromiseView {
        master.createNewPromiseView = createNPView
        master.view.blur(.Dark)
        createNPView.alpha = 0
        createNPView.frame = master.view.frame
//        createNPView.bounds = CGRectMake(0, 0, self.master.view.frame.width, self.master.view.frame.height * 0.7)
        master.view.addSubview(createNPView)
        createNPView.center.x = master.view.center.x
        createNPView.fadeIn()
        createNPView.displayChoices()
//        createNPView.slide(.right)
        
        
      }
     
    }
  
  }
  
  
  // MARK: -- custom functions
  
  
  
  func doShowHelpPages() {
    
  }
  
  
  
  func doWasCreated() {
    if let master = self.master as? MainViewController {
      let brain = getAppDelegate().GPS_Brain
      let mapView = MKMapView()
      mapView.alpha = 0
      brain.focus = mapView
      brain.getCurrentLocation()
      master.viewContainsMap.addSubview(mapView)
      mapView.frame = master.view.frame
      mapView.center = master.view.center
      mapView.userInteractionEnabled = false
//      mapView.setRegion(region, animated: true)
      
    }
  }
  



// MARK: -- required functions
init(master: MainViewController) { super.init(_master: master) ; doWasCreated() }
  
} // end of model class