//
//  GPSBrain.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/24/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class GPSBrain: NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
  
  
  // MARK: -- variables
  var LM: CLLocationManager!
  var focus: MKMapView? {
    didSet {
      focus?.showsUserLocation = true
      focus?.delegate = self
    }
  }
  var currentLocation: CLLocation?
  var pinColor: UIColor?
  
  var hasPermissionNow: Bool {
    if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse { return true }
    return false
  }
  
  
  // MARK: -- other mapKit delegate methods
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    let pin = MKPinAnnotationView()
    pin.annotation = annotation
    SAFE(pinColor) { pin.tintColor = $0 }
    return pin
  }
  
  
  // MARK: -- CLLocationManagerDelegate methods
  func initLocationManager() -> CLLocationManager {
    let LM = CLLocationManager()
    return LM
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    SAFE(getAppDelegate().currentDominantVC) { $0.view.unBlur() }
    switch status {
    case .AuthorizedAlways:
      print("Authorized Always")
//      getCurrentLocation()
    case .AuthorizedWhenInUse:
      print("Authorized Partially")
    case .Denied:
      print("Refused or something")
    case .NotDetermined:
      print("Not determined")
    case .Restricted:
      print("Restricted")
    }
  }
  

  func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
    //
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("updated locations")
    if let location = locations.last {
      SAFE(self.focus) { focus in
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        focus.setRegion(region, animated: true)
        
//        focus.centerCoordinate = center
        
       
        
        
        
        

        
        focus.fadeIn()
      }
    }

//    LM.stopUpdatingLocation()
  }
  
  func dropPin() {
    SAFE(focus) { focus in
      let pin = MKPointAnnotation()
      pin.coordinate = focus.userLocation.coordinate
  
      
      focus.addAnnotation(pin)
    }
  }
  
  func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
    
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("Here's an error: \(error.description)")
  }
  
  
  // MARK: -- custom functions
  func centerMapOn(center: CLLocationCoordinate2D) {
    SAFE(focus) { focus in
      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
      focus.setRegion(region, animated: true)
    }
  }
  
  func checkCLPermission() {
    PF("checkCLPermission")
    switch CLLocationManager.authorizationStatus() {
    case .AuthorizedAlways, .AuthorizedWhenInUse:
      break
//      LM.startUpdatingLocation()
    case .Denied, .Restricted:
      break
    case .NotDetermined:
      print("notDetermined")
      LM.requestAlwaysAuthorization()

    }
  }
  
  func getCurrentLocation() {  // just a trigger function
    print("requesting location")
    LM.startUpdatingLocation()
//    LM.requestLocation()
//    if let location = LM.location {
//      return location
//    }
//      return nil  // boo
  }

  
  // MARK: -- required functions
  override init() {
    PC("GPSBrain")
    super.init()
    LM = initLocationManager()
    LM.delegate = self
    LM.desiredAccuracy = kCLLocationAccuracyHundredMeters
    LM.distanceFilter = 15 // edit this
    
    checkCLPermission()
    
  }
  
  
  
} // end of custom class