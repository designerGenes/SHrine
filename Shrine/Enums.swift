//
//  Enums.swift
//  CountArrivals
//
//  Created by Jaden Nation on 4/25/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation


enum ShrineAccuracy: Double {
  case small = 1.1
  case medium = 2.2
  case large = 3.3
}

enum PromiseInterval: Float {
  case daily = 1.0  // not final value at all
  case everyOtherDay = 2.0
  case weekly = 3.0
  case monthly = 4.0
  case yearly = 5.0
  case everyDecade = 10.0
}

enum SlideDirection {
  case up
  case down
  case left
  case right
}

enum Reward: String {
  case robot = "robot"
  case cake = "cake"
  case goblet = "goblet"
}
  // bad code
let rewards: [Reward] = [.robot, .cake, .goblet]

enum Punishment: String {
  case fire = "fire"
  case war = "war"
  case gelatinousCube = "gelatinousCube"
}
  // bad code
let punishments: [Punishment] = [.fire, .war, .gelatinousCube]