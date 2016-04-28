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

enum MoralCondition {
  case good
  case bad
}

enum Consequence: String {
  case good_robot = "robot"
  case good_cake = "cake"
  case good_goblet = "goblet"
  case bad_fire = "imgStepIndicatorOne"
  case bad_war = "imgStepIndicatorTwo"
  case bad_jail = "imgStepIndicatorThree"
}
  // bad code






enum VC: String {
  case main = "MainView"
  case createPromise = "CreatePromiseView"
  case listPromises = "ListPromisesView"
  case promiseDetail = "PromiseDetailView"
  
}

enum Segue: String {
  case fromMainToList = "fromMainToList"
  case fromListToDetail = "fromListToDetail"
  case fromMainToCreate = "fromMainToCreate"
}