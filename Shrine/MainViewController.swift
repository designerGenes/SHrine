//
//  ViewController.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/24/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import MapKit
import ChameleonFramework

class MainViewController: BetterViewController {
  
  
  // MARK: -- outlets
  @IBOutlet weak var btnGoToList: UIButton!
  @IBOutlet weak var btnNew: UIButton!
  @IBOutlet weak var viewContainsMap: UIView!
  @IBAction func clickedMenuButton(sender: UIButton) { handleButtonStrip(sender.tag) }
  @IBAction func unwindToMain(segue: UIStoryboardSegue) {}

  // MARK: -- variables
  var createNewPromiseView: CreateNewPromiseViewController?
  var  mapView: MKMapView?
  
  var mapObject: MKMapView? { didSet { loadMapViewIntoContainer()} }  // need this?

  // MARK: -- custom functions
  
  
  func handleButtonStrip(id: Int) {
    SAFECAST(model, type: Main_Model.self) { model in
      switch id {
      case 0:  // list
        print("Clicked 0")
        self.performSegueWithIdentifier(Segue.fromMainToList.rawValue, sender: nil)
      case 1:  // new
        model.doCreateNewPromise()
      case 2:  // help
        model.doShowHelpPages()
      default:
        print("Oh lawd something went wrong")
      }
    }
  }
  
  func loadMapViewIntoContainer() {
    print("Got object, trying to load")
    SAFE(self.mapObject) { MO in
      
      MO.frame = self.view.frame
      MO.clipsToBounds = true
      self.viewContainsMap.addSubview(MO)
      MO.center = self.viewContainsMap.center
    }
  }

  
  func didLoadStuff() {
    model = Main_Model(master: self)
    
  }

  func willAppearStuff() {
    
  }

  func didAppearStuff() {

    
    
    viewContainsMap.clipsToBounds = true
//    viewContainsMap.roundCorners()
    
    
  }
  
  // MARK: -- segue functions
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    SAFE(sender) { sender in
      
    }
    super.prepareForSegue(segue, sender: sender)
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
  
  override func viewWillDisappear(animated: Bool) {
    SAFE(mapView) { mapView in
      SAFE(getAppDelegate().GPS_Brain.focus) { focus in
        if mapView == focus {
          getAppDelegate().GPS_Brain.focus = nil  // cleanup code just for kicks
        }
      }
    }
    super.viewWillDisappear(animated)
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

