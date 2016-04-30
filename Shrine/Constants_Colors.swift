//
//  Colors.swift
//  Shrine
//
//  Created by Jaden Nation on 4/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import SwiftHEXColors
import ChameleonFramework


public enum projColor: String {
  case red_bright = "red_bright"
  case yellow_bright = "yellow_bright"
  case blue_bright = "blue_bright"
  case orange_bright = "orange_bright"
  case green_bright = "green_bright"
  case white_bright = "white_bright"
  
  case red_accent = "red_accent"
  case yellow_accent = "yellow_accent"
  case blue_accent = "blue_accent"
  case orange_accent = "orange_accent"
  case green_accent = "green_accent"
  case black_accent = "black_accent"
  
  case gray_light = "gray_light"
  case gray_accent = "gray_accent"
}



public let colors: [String: UIColor] = [
  // BRIGHT
  projColor.red_bright.rawValue: UIColor(hexString: "#E94F37")!,
  projColor.yellow_bright.rawValue: UIColor(hexString: "#FFDD4A")!,
  projColor.blue_bright.rawValue: UIColor(hexString: "#5BC0EB")!,
  projColor.orange_bright.rawValue: UIColor(hexString: "#FA7921"),
  projColor.green_bright.rawValue: UIColor(hexString: "#20CE6C")!,
  projColor.white_bright.rawValue: UIColor(hexString: "#F7F7F7")!,
  // ACCENT
  projColor.red_accent.rawValue: UIColor(hexString: "#B34040")!,
  projColor.yellow_accent.rawValue: UIColor(hexString: "#E3CB5F")!,
  projColor.blue_accent.rawValue: UIColor(hexString: "#29335C")!,
  projColor.orange_accent.rawValue: UIColor(hexString: "#FF9F5E")!,
  projColor.green_accent.rawValue: UIColor(hexString: "#19AE5C")!,
  
  // UTILITY
  projColor.gray_light.rawValue: UIColor(hexString: "#E6E6EA")!,
  projColor.gray_accent.rawValue: UIColor(hexString: "#373B39")!
]