//
//  MainViewController.swift
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
  @IBOutlet weak var mapView: MKMapView!
  
  @IBAction func clickedMenuButton(sender: UIButton) { handleButtonStrip(sender.tag) }
  @IBAction func unwindToMain(segue: UIStoryboardSegue) {}

  @IBOutlet weak var btnHelp: UIButton!
  

  // MARK: -- variables
  var createNewPromiseView: CreateNewPromiseViewController?
  
//  var mapObject: MKMapView? // { didSet { loadMapViewIntoContainer()} }  // need this?  GUESS NOT! 

  // MARK: -- custom functions
  override func segueForUnwindingToViewController(toViewController: UIViewController, fromViewController: UIViewController, identifier: String?) -> UIStoryboardSegue {
    if let id = identifier {
      if id != "unwind_ListToMain" {  // because for now this is a Modal segue
        let unwindSegue = lateralSegue_Back(identifier: id, source: fromViewController, destination: toViewController, performHandler: { () -> Void in
          
        })
      
        return unwindSegue
      }
    }
    
    return super.segueForUnwindingToViewController(toViewController, fromViewController: fromViewController, identifier: identifier)!
  }
  
  
  func handleButtonStrip(id: Int) {
    SAFECAST(model, type: Main_Model.self) { model in
      switch id {
      case 0:  // list
        print("Clicked 0")
        self.performSegueWithIdentifier(Segue.fromMainToList.rawValue, sender: self)
      case 1:   // settings
        self.performSegueWithIdentifier(Segue.fromMainToSettings.rawValue, sender: self)
        break
      case 2:  // new
        model.doCreateNewPromise()
      case 3:  // help
        self.performSegueWithIdentifier(Segue.fromMainToHelp.rawValue, sender: self)
      default:
        print("Oh lawd something went wrong")
      }
    }
  }


  
  func didLoadStuff() {
    model = Main_Model(master: self)
    SAFECAST(model, type: Main_Model.self) { $0.doViewAppeared() }
  }

  func willAppearStuff() {
    
  }

  func didAppearStuff() {
    mapView.delegate = getAppDelegate().GPS_Brain
    SAFECAST(model, type: Main_Model.self) { model in
//      model.doViewAppeared()
    }
  }
  
  // MARK: -- segue functions
  
  
//  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//    
//    super.prepareForSegue(segue, sender: sender)
//  }

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
//          getAppDelegate().GPS_Brain.focus = nil  // cleanup code just for kicks
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

