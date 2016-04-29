//
//  PromiseTableViewCell.swift
//  Shrine
//
//  Created by Jaden Nation on 4/28/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import CoreData

class PromiseTableViewCell: UITableViewCell {
  // MARK: -- outlets
  @IBOutlet weak var lblShrineNickname: UILabel!
  @IBOutlet weak var btnPromiseHealthIndicator: UIButton!
  
  @IBAction func clickedHealthIndicator(sender: UIButton) { doClickedHealthIndicator() }
  
  // MARK: -- variables 
  var id: NSManagedObjectID!
  
  // MARK: -- custom functions
  func doClickedHealthIndicator() {
    
  }
  
  
  // MARK: -- required functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
