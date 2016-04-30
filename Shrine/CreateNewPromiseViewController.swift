//
//  CreateNewPromiseView.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import SwiftHEXColors

class CreateNewPromiseViewController: BetterViewController, UITextFieldDelegate {
  
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
  
  @IBAction func clickedInterval(sender: SegmentedButton) { doClickedInterval(sender) }
  
  @IBAction func clickedGo(sender: UIButton) { willAskForConsequences(.good) }
  
  
  // MARK: -- variables
  static var previousColor: UIColor?
  
  var shrineTitle: String?
  var shrineColor: String!
  var selectedReward: Consequence? ; var selectedPunishment: Consequence? ; var selectedInterval: Int? = 7

  var consequenceButtons = [UIView]()
  var intervalButtons: [UIButton]!
  var screenObjects: [UIView]!
  var nicknameControlSet: [UIView]! ; var intervalControlSet: [UIView]! ; var consequenceControlSet: [[Consequence]]!
  var rewardControlSet = [UIImageView]() ; var punishmentControlSet = [UIImageView]()
  
  var tempConsequences :[MoralCondition:[Consequence]]?
  
  var textFieldReturnPosition: CGFloat?
  
  let colorChoices: [UIColor] = [
    colors[projColor.blue_bright.rawValue]!,
    colors[projColor.red_bright.rawValue]!,
    colors[projColor.yellow_bright.rawValue]!,
    colors[projColor.green_bright.rawValue]!,
    ]
  
  
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
    
  }
  
  func doClickedInterval(sender: SegmentedButton) {
    intervalButtons.map { $0.selected = false }
    sender.selected = true
    switch sender.tag {
    case PromiseIntervalTag.oneDay.rawValue: selectedInterval = 1
    case PromiseIntervalTag.sevenDays.rawValue: selectedInterval = 7
    case PromiseIntervalTag.thirtyDays.rawValue: selectedInterval = 30
    case PromiseIntervalTag.customDays.rawValue: askForCustomInterval(sender)
    default: break
    }
  }
  
  func askForCustomInterval(sender: SegmentedButton) {
    let customerIntervalAlert = BetterAlert(title: "Custom Interval", message: STR_QuestionCustomInterval, hasCancel: true, vc: self, cancelAction: {
      sender.selected = false
      }) { 
        self.selectedInterval = 5  // NOTE: replace this with a custom alert controller WITH text field
    }
  }
  
  func doHandleTextInput(field: UITextField) {
    if field.text?.characters.count > 0 {
      btnGo.enabled = true
    } else { btnGo.enabled = false   }
  }
  
  func doSelectConsequence(sender: UIButton) {
    if selectedReward == nil {  // first pass
      self.selectedReward = getAppDelegate().consequences[.good]![sender.tag]
      doRemoveConsequenceButtons()
      wait(GLOBAL_FADE_TIME) {
        self.doAskForConsequences(.bad)
      }
    } else if selectedPunishment == nil {  // second pass
      self.selectedPunishment = getAppDelegate().consequences[.bad]![sender.tag]
      doRemoveConsequenceButtons()
      wait(GLOBAL_FADE_TIME) {
        self.view.unBlur()
        self.doAskToFinalize()
      }
      
    }
    
  }
  
  func doRemoveConsequenceButtons() {
    (0..<consequenceButtons.count).map { count in
      let time = GLOBAL_FADE_TIME + NSTimeInterval(Double(count) * 0.1)
      let button = consequenceButtons[count]
      
      if button is UILabel {
        animateThen(GLOBAL_FADE_TIME, animations: { 
          button.alpha = 0
          }, completion: { 
            button.removeFromSuperview()
        })
      } else {
        button.slide(.down, distanceAndTime: (self.view.frame.height, time)) {
          button.removeFromSuperview()
        }
      }
    }
  }
  
  func doAskToFinalize() {
    PF("doAskToFinalize")
    
    let questionAlert = BetterAlert(title: "Finalize?", message: STR_QuestionFinalizePromise, hasCancel: true, vc: self, cancelAction:  {
      self.performSegueWithIdentifier(Segue.fromCreateToMain.rawValue, sender: nil)
    }, okAction: {
      SAFECAST(self.model, type: CreateNew_Model.self) { model in
        model.doCreateNewDataObjects()
      }
    })
    
  }
  
  
  func willAskForConsequences(type: MoralCondition) {
    txtNickname.resignFirstResponder()  // hacky
    SAFE(txtNickname.text) { self.shrineTitle = $0 }
    self.view.blur(1, style: .Dark)
    doAskForConsequences(type)
  }
  
  func doAskForConsequences(type: MoralCondition) {
    if let set = getAppDelegate().consequences[type] {
      
      // step 1: create label
      
      let lblConsequence = UILabel()
      lblConsequence.textAlignment = .Center; lblConsequence.frame.size = CGSize(width: view.widthWithMargins(), height: view.frame.height * 0.3)
      lblConsequence.numberOfLines = 0
      lblConsequence.lineBreakMode = NSLineBreakMode.ByWordWrapping
      lblConsequence.text = "Choose \({type == .good ? STR_ChooseReward : STR_ChoosePunishment }())"
      lblConsequence.textColor = UIColor.flatWhiteColor()
      lblConsequence.alpha = 0
    
    
      // step 2: display consequence buttons
      self.consequenceButtons.removeAll()
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
        if count == 0 { btnConsequence.center.x = self.view.center.x }
        
        btnConsequence.addTarget(self, action: #selector(self.doSelectConsequence(_:)), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(btnConsequence)
        self.consequenceButtons.append(btnConsequence)
        btnConsequence.fadeIn()
      
      }
      
      // step 3: fade in label and position above buttons
      SAFE(self.consequenceButtons.first) { firstBtn in
        self.view.addSubview(lblConsequence)
        lblConsequence.center = CGPointMake(self.view.center.x, (firstBtn[0].y-lblConsequence.frame.height/3))
        lblConsequence.fadeIn()
        self.consequenceButtons.append(lblConsequence)
        
      }
    
    }
  }
  
  func generateRandomColor() -> UIColor {
    let out = colorChoices[rollDice(colorChoices.count)]
    if let previousColor = CreateNewPromiseViewController.previousColor {
      if out == previousColor { return generateRandomColor() }
    }
    return out
  }
  
  func doSubmitShrine() {
    SAFE(self.view.superview) { $0.unBlur() }
    self.view.slide(.up, distanceAndTime: nil) {  // if distance is nil, slide across entire screen
      self.view.subviews.map { $0.removeFromSuperview() }
      self.view.removeFromSuperview()
    }
  }
  
  // MARK: -- UITextView delegate methods
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    txtNickname.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    self.textFieldReturnPosition = viewContainsControlSets.center.y
   viewContainsControlSets.slide(.up, distanceAndTime: (distance: 100, time: GLOBAL_FADE_TIME))

  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    SAFE(textFieldReturnPosition) { returnY in
      let distance: CGFloat = (returnY - self.viewContainsControlSets.center.y)
      self.viewContainsControlSets.slide(.down, distanceAndTime: (distance: distance, time: GLOBAL_FADE_TIME))
      print("Editing done")
    }
  }
  
  
  // MARK: -- load functions
  func didLoadStuff() {
    model = CreateNew_Model(master: self)
    txtNickname.addTarget(self, action: #selector(CreateNewPromiseViewController.doHandleTextInput(_:)), forControlEvents: UIControlEvents.EditingChanged)
    intervalButtons = [ btnOneDay, btnSevenDays, btnThirtyDays, btnCustomDays ]
    txtNickname.autocorrectionType = .No
    txtNickname.delegate = self
  }
  
  func willAppearStuff() {
    viewContainsControlSets.layer.cornerRadius = 8  // why 8?
    btnGo.enabled = false
    btnSevenDays.selected = true
    
  
   
    
    
    let uniqueColor = self.generateRandomColor()
    CreateNewPromiseViewController.previousColor = uniqueColor
    view.backgroundColor = uniqueColor
    shrineColor = uniqueColor.hexValue()
    
    
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
