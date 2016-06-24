//
//  TaskTableViewCell.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/9/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

public class TaskTableViewCell: UITableViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var notesLabel: UILabel!
  @IBOutlet public var checkbox: Checkbox!
  
  public func configureForTask(_ task: Task) {
    titleLabel.text = task.title
    notesLabel.text = task.notes
    configureForDoneState(task.done)
  }
  
  func configureForDoneState(_ done: Bool) {
    checkbox.isChecked = done
    if done {
      backgroundColor = .lightGray()
      titleLabel.alpha = 0.5
      notesLabel.alpha = 0.5
    } else {
      backgroundColor = .white()
      titleLabel.alpha = 1
      notesLabel.alpha = 1
    }
  }
  
  @IBAction func tappedCheckbox() {
    configureForDoneState(!checkbox.isChecked)
    
    //TODO: Actually mark task done
  }
}
