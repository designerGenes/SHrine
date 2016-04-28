//
//  CreateNewPromiseView.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit

class CreateNewPromiseView: UIView {
  
  // MARK: -- outlets
  @IBOutlet weak var imgPin: UIImageView!
  @IBOutlet weak var txtNickname: UITextField!
  @IBOutlet weak var lblNickname: UILabel!
  @IBOutlet weak var btnGo: UIButton!
  @IBOutlet weak var btnOneDay: UIButton!
  @IBOutlet weak var btnThirtyDays: UIButton!
  @IBOutlet weak var btnSevenDays: UIButton!
  @IBOutlet weak var btnCustomDays: UIButton!
  @IBOutlet weak var viewContainsRewards: UIView!
  
  
  
  
  @IBAction func typedInNickname(sender: UITextField) {  }
  

  
//  @IBAction func clickedRewardBtn(sender: UIButton) { selectReward(sender.tag) }
  @IBAction func clickedGo(sender: UIButton) { doSubmitShrine() }
  
  
  // MARK: -- variables
  var shrineTitle: String?
  var reasonWhy: String?
  var selectedReward: Reward?
  var selectedPunishment: Punishment?
  var buttons = [UIButton]()
  
//  var interval: 
  
  // MARK: -- animation functions
    
  
  // MARK: -- custom functions
  func displayChoices() {
    if selectedReward == nil { createChoicesButtons(rewards.map({$0.rawValue})) }
    else { createChoicesButtons(punishments.map({$0.rawValue})) }
    

    
  }
  
  func createChoicesButtons(choices: [String]) {
    if buttons.count > 0 {     //    clear screen just in case
      buttons.map { SV in SV.slide(.right) { SV.removeFromSuperview() } }
    }
    
    
    (0..<choices.count).map { count in
      SAFE(self.superview) { SV in
//        let timer = Double(count) * (GLOBAL_FADE_TIME * 0.8)
        let VCW = self.viewContainsRewards
        let outButton = UIButton(frame: CGRectMake(CGPointZero.x, CGPointZero.y, (VCW.bounds.width / 3 ) * 0.5, (VCW.bounds.width / 3 ) * 0.5))
        self.viewContainsRewards.addSubview(outButton)
        outButton.tag = count
        outButton.setBackgroundImage(UIImage(named: choices[count]), forState: .Normal)
        outButton.setBackgroundImage(UIImage(named: "robot")!, forState: .Highlighted)
        outButton.userInteractionEnabled = true
        outButton.enabled = true
        outButton.addTarget(self, action: #selector(self.didMakeChoice(_:)), forControlEvents: .TouchUpInside)
        
        print("Center Y of master is \(VCW.center.y)")
        outButton.center.y = VCW.bounds.height / 2
        outButton.center.x = (((VCW.bounds.width * 0.75) / 3) * CGFloat(count)) + outButton.frame.width/2 - VCW.bounds.width
        outButton.slide(.right)
        self.buttons.append(outButton)
      }
    }
  }
  
  func didMakeChoice(sender: UIButton) {
    print("OH Lawd")
    if selectedReward == nil { selectedReward = rewards[sender.tag] }
    else { selectedPunishment = punishments[sender.tag] }
    
    if (selectedReward == nil) || (selectedPunishment == nil) {
      displayChoices()
    } else {
      
    }
  }
  
  
  func doSubmitShrine() {
    SAFE(self.superview) { $0.unBlur() }
    slide(.up) {
      self.subviews.map { $0.removeFromSuperview() }
      self.removeFromSuperview()
    }
  }
  
  
  
  // MARK: -- load functions
  func didLoadStuff() {
    
  }
  
  func willAppearStuff() {
    
  }
  
  func didAppearStuff() {
  }
  
  // MARK: -- required functions

  
} // end of class
