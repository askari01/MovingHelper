//
//  StartOfDayNSDateExtension.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/20/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/**
A quick extension to save having to grab NSCalendar references everywhere.
*/
extension Date {
  
  /**
  The start of the day per NSCalendar rules for the receiver.
  */
  func startOfDay() -> Date {
    return Calendar.current().startOfDay(for: self)
  }
  
  /**
  The start of the current day per NSCalendar rules for the receiver.
  */
  static func startOfToday() -> Date {
    return Date().startOfDay()
  }
}
