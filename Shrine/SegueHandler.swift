//
//  SegueBrain.swift
//  Shrine
//
//  Created by Jaden Nation on 5/1/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit


class lateralSegue_Forward: UIStoryboardSegue {
  
  override func perform() {
    let fromVC = self.sourceViewController
    let toVC = self.destinationViewController
    let VCs: [UIViewController] = [fromVC, toVC]
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    
    toVC.view.frame = CGRectMake(screenWidth, 0, screenWidth, screenHeight)
    

    if let newPromiseVC = destinationViewController as? CreateNewPromiseViewController {
      newPromiseVC.view.backgroundColor = newPromiseVC.generateRandomColor()
    }
    
    if let window = UIApplication.sharedApplication().keyWindow {
      window.insertSubview(toVC.view, aboveSubview: fromVC.view)
    
//    animateThen(GLOBAL_TRANSITION_TIME/2, animations: {
//      for VC in VCs { VC.view.transform =  CGAffineTransformScale(VC.view.transform, 0.75, 0.75) }
//      }) {
    animateThen(GLOBAL_TRANSITION_TIME, animations: {
        toVC.view.frame = CGRectOffset(toVC.view.frame, -screenWidth, 0)
        fromVC.view.frame = CGRectOffset(fromVC.view.frame, -screenWidth, 0)
    }) {
    self.sourceViewController.presentViewController(toVC, animated: false, completion: nil)
//      animate(GLOBAL_TRANSITION_TIME/2) {
//        for VC in VCs { VC.view.transform =  CGAffineTransformIdentity }  // actually important to do both for some reason
//      }
      
      
        }
      }
  }
}

class lateralSegue_Back: UIStoryboardSegue {
  // destinationViewController = MainVC
  // sourceViewController = CreateNewPromiseViewControler
  
  override func perform() {
    let fromVC = self.sourceViewController.view
    let toVC = self.destinationViewController.view
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    let screenHeight = UIScreen.mainScreen().bounds.size.height
    toVC.frame = CGRectMake(-screenWidth, 0, screenWidth, screenHeight)
    
    
    if let window = UIApplication.sharedApplication().keyWindow {
      window.insertSubview(toVC, aboveSubview: fromVC)
      print("Beginning animations")
      animateThen(GLOBAL_TRANSITION_TIME, animations: {
        toVC.frame = CGRectOffset(toVC.frame, screenWidth, 0)
        fromVC.frame = CGRectOffset(fromVC.frame, screenWidth, 0)
        
      }) {
        self.sourceViewController.dismissViewControllerAnimated(false, completion: nil)
        
      }
    }
  }
}