//
//  CreateNewPromiseView.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit

class CreateNewPromiseViewController: BetterViewController {
  
  // MARK: -- outlets

  @IBOutlet weak var imgShrine: UIImageView!
  @IBOutlet weak var txtNickname: UITextField!
  @IBOutlet weak var lblNickname: UILabel!
  @IBOutlet weak var btnGo: UIButton!
  @IBOutlet weak var btnOneDay: SegmentedButton!
  @IBOutlet weak var btnSevenDays: SegmentedButton!
  @IBOutlet weak var btnThirtyDays: SegmentedButton!
  @IBOutlet weak var btnCustomDays: SegmentedButton!
  @IBOutlet weak var viewContainsControlSets: UIView!
  

  @IBAction func typedInNickname(sender: UITextField) {  }
  

  
//  @IBAction func clickedRewardBtn(sender: UIButton) { selectReward(sender.tag) }
  @IBAction func clickedGo(sender: UIButton) { willAskForConsequences(.good) }
  
  
  // MARK: -- variables
  var shrineTitle: String?
  var consequenceButtons = [UIButton]()
  
  var screenObjects: [UIView]!
  var nicknameControlSet: [UIView]! ; var intervalControlSet: [UIView]! ; var consequenceControlSet: [[Consequence]]!
  var rewardControlSet = [UIImageView]() ; var punishmentControlSet = [UIImageView]()
  
  var tempConsequences :[MoralCondition:[Consequence]]?
  
  var selectedReward: Consequence? ; var selectedPunishment: Consequence?
  
//  var interval: 
  
  // MARK: -- animation functions
    
  
  // MARK: -- custom functions
  func kickstartCycle() {
    PF("kickstartCycle")
    screenObjects = [
      txtNickname, lblNickname, btnGo, btnOneDay, btnThirtyDays, btnSevenDays, btnCustomDays
    ]
    nicknameControlSet = [
      txtNickname, lblNickname
    ]
    intervalControlSet = [
      btnOneDay, btnSevenDays, btnThirtyDays, btnCustomDays
    ]
//    consequenceControlSet = [rewardControlSet, punishmentControlSet]()  // docile and sleepy for now
    
//    tempConsequences = getAppDelegate().consequences
    
    // commands
//    screenObjects.map { $0.translatesAutoresizingMaskIntoConstraints = false }
//
//    txtNickname.translatesAutoresizingMaskIntoConstraints = false
//    txtNickname.frame = CGRectMake(0, 0, 330, 330)
    
//    nicknameControlSet.map { $0.backgroundColor = UIColor.redColor() }
//    intervalControlSet.map { $0.center.y = self.frame.height * 2 }
    
    
    
  }
  
  func doSelectConsequence(sender: UIButton) {
    if selectedReward == nil {  // first pass
      print("first Pass")
      self.selectedReward = getAppDelegate().consequences[.good]![sender.tag]
      doRemoveConsequenceButtons()
      doAskForConsequences(.bad)
    } else if selectedPunishment == nil {  // second pass
      print("secondPass")
      self.view.unBlur()
      self.selectedPunishment = getAppDelegate().consequences[.bad]![sender.tag]
      doRemoveConsequenceButtons()
      
      doAskToFinalize()
      
    }
    
  }
  
  func doRemoveConsequenceButtons() {
    consequenceButtons.map { button in
      let button = button as! UIButton
      // this will be fancier later
     animateThen(GLOBAL_FADE_TIME, animations: { 
      button.alpha = 0
      }, completion: {  button.removeFromSuperview() })
    }
  }
  
  func doAskToFinalize() {
    PF("doAskToFinalize")
  }
  
  
  func willAskForConsequences(type: MoralCondition) {
    //  check text fields and then...
    self.view.blur(1, style: .Dark)
    doAskForConsequences(type)
  }
  
  func doAskForConsequences(type: MoralCondition) {
    print("Asking for consequences")
    if let set = getAppDelegate().consequences[type] {
      self.consequenceButtons.removeAll()
      print(set.count)
      (0..<set.count).map { count in
        let safeWidth = self.view.frame.width / CGFloat(set.count); let safeHeight = safeWidth // duh
        let frame = CGRectMake(0, 0, safeWidth, safeWidth)
        let btnConsequence = UIButton(frame: frame)
        btnConsequence.setImage(UIImage(named: set[count].rawValue), forState: .Normal)
        btnConsequence.userInteractionEnabled = true
        btnConsequence.tag = count
        btnConsequence.alpha = 0
        
        if count % 2 == 0 || count == 0 {  // even button
          
          btnConsequence.center.y = self.view.center.y - safeHeight + (safeHeight * CGFloat(Int(count/2))*1.2)
          btnConsequence.center.x = self.view.center.x - (safeWidth/2)*1.2
        } else {            // odd button
          btnConsequence.center.y = self.view.center.y - safeHeight + (safeHeight * CGFloat(Int(count-1/2))*1.2)
          btnConsequence.center.x = self.view.center.x + (safeWidth/2)*1.2
        }
        btnConsequence.addTarget(self, action: #selector(self.doSelectConsequence(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(btnConsequence)
        self.consequenceButtons.append(btnConsequence)
        btnConsequence.fadeIn()
//        btnConsequence.center.y = self.view.center.y
//        btnConsequence.center.x = (safeWidth/2) + (CGFloat(count) * safeWidth) - self.view.frame.width
      
    }
    
  }
  
  
  func displayChoices() {
//    if selectedReward == nil { createChoicesButtons(rewards.map({$0.rawValue})) }
//    else { createChoicesButtons(punishments.map({$0.rawValue})) }
    

    
  }
  
  func createChoicesButtons(choices: [String]) {
//    if buttons.count > 0 {     //    clear screen just in case
//      buttons.map { SV in SV.slide(.right) { SV.removeFromSuperview() } }
//    }
    
    
//    (0..<choices.count).map { count in
//      SAFE(self.superview) { SV in
////        let timer = Double(count) * (GLOBAL_FADE_TIME * 0.8)
//        let VCW = self.viewContainsRewards
//        let outButton = UIButton(frame: CGRectMake(CGPointZero.x, CGPointZero.y, (VCW.bounds.width / 3 ) * 0.5, (VCW.bounds.width / 3 ) * 0.5))
//        self.viewContainsRewards.addSubview(outButton)
//        outButton.tag = count
//        outButton.setBackgroundImage(UIImage(named: choices[count]), forState: .Normal)
//        outButton.setBackgroundImage(UIImage(named: "robot")!, forState: .Highlighted)
//        outButton.userInteractionEnabled = true
//        outButton.enabled = true
//        outButton.addTarget(self, action: #selector(self.didMakeChoice(_:)), forControlEvents: .TouchUpInside)
//        
//        print("Center Y of master is \(VCW.center.y)")
//        outButton.center.y = VCW.bounds.height / 2
//        outButton.center.x = (((VCW.bounds.width * 0.75) / 3) * CGFloat(count)) + outButton.frame.width/2 - VCW.bounds.width
//        outButton.slide(.right)
//        self.buttons.append(outButton)
//      }
//    }
  }
//  
//  func didMakeChoice(sender: UIButton) {
//    print("OH Lawd")
//    if selectedReward == nil { selectedReward = rewards[sender.tag] }
//    else { selectedPunishment = punishments[sender.tag] }
//    
//    if (selectedReward == nil) || (selectedPunishment == nil) {
//      displayChoices()
//    } else {
//      
//    }
//  }
  }
  
  
  func doSubmitShrine() {
    SAFE(self.view.superview) { $0.unBlur() }
    self.view.slide(.up, distance: nil) {  // if distance is nil, slide across entire screen
      self.view.subviews.map { $0.removeFromSuperview() }
      self.view.removeFromSuperview()
    }
  }
  
  
  
  // MARK: -- load functions
  func didLoadStuff() {
    model = CreateNew_Model(master: self)
  }
  
  func willAppearStuff() {
    viewContainsControlSets.layer.cornerRadius = 8  // why 8?
    
  }
  
  func didAppearStuff() {
  }
  
  // MARK: -- required functions
  override func viewDidLoad() {
    didLoadStuff()
    super.viewDidLoad()
  }
  override func viewWillAppear(animated: Bool) {
    willAppearStuff()
    super.viewWillAppear(animated)
  }
  override func viewDidAppear(animated: Bool) {
    didAppearStuff()
    super.viewDidAppear(animated)
  }
  
  
  
  
} // end of class
