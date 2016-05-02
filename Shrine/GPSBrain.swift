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
  var focus: MKMapView?
  var currentLocation: CLLocation?
  
  var hasPermissionNow: Bool {
    if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse { return true }
    return false
  }
  
  
  
  
  // MARK: -- CLLocationManagerDelegate Functions
  func initLocationManager() -> CLLocationManager {
    let LM = CLLocationManager()
    return LM
  }
  
  func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    SAFE(getAppDelegate().currentDominantVC) { $0.view.unBlur() }
    switch status {
    case .AuthorizedAlways:
      print("Authorized Always")
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
  
  
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    print("updated locations")
    if let location = locations.last {
      if let focus = self.focus {
        print("We have a focus!")
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        focus.setRegion(region, animated: true)
        focus.fadeIn()
      }
    }
    
    LM.stopUpdatingLocation()
  }
  
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("Here's an error: \(error.description)")
  }
  
  
  // MARK: -- custom functions
  func getCityFromCoordinate(coord: CLLocationCoordinate2D) -> String {
    var out = "" ; // let geoCoder = CLGeocoder()
//    let queue = dispatch_group_create()
//    dispatch_group_enter(queue)
//    dispatchToBackground {
//      let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
//      geoCoder.reverseGeocodeLocation(location) { (placemarks, error) -> Void in
//        SAFE(placemarks?.first) { place in
//          if let city = place.addressDictionary!["City"] as? String {
//            out = city
//            dispatchToMain { dispatch_group_leave(queue) } // I think this will lock up
//          }
//        }
//      }
//    }
//    dispatch_group_wait(queue, DISPATCH_TIME_FOREVER)
//    print("Found city and it is \(out)")
    return out
  }
  
  
  func checkCLPermission() {
    PF("checkCLPermission")
    switch CLLocationManager.authorizationStatus() {
    case .AuthorizedAlways, .AuthorizedWhenInUse:
      LM.startUpdatingLocation()
    case .Denied, .Restricted:
      break
    case .NotDetermined:
      print("notDetermined")
//      SAFE(getAppDelegate().currentDominantVC) { $0.blur() }
      LM.requestAlwaysAuthorization()

    }
  }
  
  func getCurrentLocation() -> CLLocation? {
      print("Made it here")
      LM.requestLocation()
    if let location = LM.location {
      print("Got Location")
      return location
//      let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//      let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
//      out.setRegion(region, animated: true)
    }
      return nil  // boo
  }

  
  // MARK: -- required functions
  override init() {
    PC("GPSBrain")
    super.init()
    LM = initLocationManager()
    LM.delegate = self
    LM.desiredAccuracy = kCLLocationAccuracyBest  // possible should be variable
    checkCLPermission()
    
  }
  
  
  
} // end of custom class