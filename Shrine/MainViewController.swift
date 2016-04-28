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
  enum Segue: String {
    case toListPosts = "toListPosts"
  }
  
  
  // MARK: -- outlets
  @IBOutlet weak var btnGoToList: UIButton!
  @IBOutlet weak var btnNew: UIButton!
  @IBOutlet weak var viewContainsMap: UIView!
  @IBAction func clickedMenuButton(sender: UIButton) { handleButtonStrip(sender.tag) }
  @IBAction func unwindToMain(segue: UIStoryboardSegue) {}

  // MARK: -- variables
  var createNewPromiseView: CreateNewPromiseView?
  var mapObject: MKMapView? { didSet { loadMapViewIntoContainer()} }

  // MARK: -- custom functions
  
  
  func handleButtonStrip(id: Int) {
    SAFECAST(model, type: Main_Model.self) { model in
      switch id {
      case 0:  // list
        print("Clicked 0")
        self.doSegue(.toListPosts)
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
  func doSegue(id: Segue, withItem: AnyObject? = nil) {
    performSegueWithIdentifier(id.rawValue, sender: withItem)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    SAFE(sender) { sender in
      
    }
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

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    willAppearStuff()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

} // end of class

