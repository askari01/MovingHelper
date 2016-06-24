//
//  Checkbox.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/9/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

/**
A button subclass to make it simpler to display and update whether a
Task is done or not.
*/
public class Checkbox: UIButton {
  
  //MARK: Properties
  
  public var isChecked = false {
    didSet {
      if isChecked {
        self.setTitle("✔︎", for: UIControlState())
      } else {
        self.setTitle("", for: UIControlState())
      }
    }
  }
  
  //MARK: View Lifecycle
  
  override public func awakeFromNib() {
    super.awakeFromNib()
    
    //Setup styles
    self.layer.borderColor = UIColor.black().cgColor
    self.layer.borderWidth = 1
    self.layer.cornerRadius = 4
    
    //Note: Removing the UIColor from .blackColor() here causes a Swift
    // compiler error as of Xcode 6.3.2
    self.setTitleColor(UIColor.black(), for:UIControlState())
  }
}
