//
//  MovingDateViewController.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

public protocol MovingDateDelegate {
  func createdMovingTasks(_ tasks: [Task])
  func updatedMovingDate()
}

/**
VC to use to select a moving date.
*/
class MovingDateViewController: UIViewController {
  
  @IBOutlet weak var whenMovingDatePicker: UIDatePicker!
  @IBOutlet weak var whenMovingLabel: UILabel!
  @IBOutlet weak var daysLeftLabel: UILabel!
  @IBOutlet weak var createTasksButton: UIButton!
  var updatingDate = false
  var delegate: MovingDateDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Localize strings
    whenMovingLabel.text = LocalizedStrings.whenMovingTitle
    
    whenMovingDatePicker.minimumDate = Date.startOfToday()
    
    if let movingDate = UserDefaults.standard().object(forKey: UserDefaultKey.MovingDate.rawValue) as? Date {
      whenMovingDatePicker.date = movingDate
      createTasksButton.setTitle(LocalizedStrings.updateDate, for: UIControlState())
    } else {
      whenMovingDatePicker.date = twoMonthsFromToday()
      createTasksButton.setTitle(LocalizedStrings.createTasks,
        for: UIControlState())
    }
    
    datePickerChanged()
  }
  
  //MARK: Date helpers
  
  func twoMonthsFromToday() -> Date {
    let currentCalendar = Calendar.current()
    
    let today = Date.startOfToday()
    var twoMonths = DateComponents()
    twoMonths.month = 2
    let updatedDate = currentCalendar.date(byAdding: twoMonths,
      to: today,
      options: [])
    return updatedDate!
  }
  
  //MARK: IBActions
  
  @IBAction func datePickerChanged() {
    let updatedDate = whenMovingDatePicker.date.startOfDay()
    let today = Date.startOfToday()
    
    let components = Calendar.current().components(.day,
      from: today,
      to: updatedDate,
      options: [])
    
    daysLeftLabel.text = NSString(format: LocalizedStrings.daysLeftFormat, components.day!) as String
  }
  
  @IBAction func createTasks() {
    let updatedDate = whenMovingDatePicker.date.startOfDay()
    
    if !updatingDate {
      //If we're not updating the date, this is a new set of tasks and we should load the stock task.
      let tasks = TaskLoader.loadStockTasks()
      delegate?.createdMovingTasks(tasks)
    }
    
    //In any case, we should update the moving date and notify the delegate it was updated.
    UserDefaults.standard().set(updatedDate, forKey: UserDefaultKey.MovingDate.rawValue)
    UserDefaults.standard().synchronize()
    delegate?.updatedMovingDate()
    
    dismiss(animated: true, completion: nil)
  }
}
