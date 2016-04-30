//
//  Constants.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit

let GLOBAL_FADE_TIME: NSTimeInterval = 0.75
let GLOBAL_MARGIN: CGFloat = 20.0
let MAX_CONSEQUENCES = 3

// MARK: -- dialogues and alerts
let STR_QuestionFinalizePromise = "You are are about to finalize this Promise.  Click YES to make this promise or CANCEL to return home."

let STR_QuestionCustomInterval = "Enter a custom interval below.  You will be making a promise to revisit this Shrine every interval of days equal to your choice here."

let STR_ChooseReward = "reward for keeping this promise"
let STR_ChoosePunishment = "swift and brutal punishment for breaking this promise"

let STR_Consequences: [String: String] = [
  Consequence.good_cake.rawValue : "a luscious slice of pound cake",
  Consequence.good_goblet.rawValue : "a goblet of blue corner store slushee",
  Consequence.good_robot.rawValue : "your very own robot",
  Consequence.bad_fire.rawValue: "your house catches on fire",
  Consequence.bad_jail.rawValue: "your dog goes to jail",
  Consequence.bad_war.rawValue: "two allied nations go to war"
]

let STR_VerifyDeletionRequest = "Are you sure you want to delete this promise?  I won't be upset but there will be no way to retrieve your streaks.  Press OK to delete to Cancel to pretend this never happened."