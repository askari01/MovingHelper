//
//  TaskSaver.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/15/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/*
Struct to save tasks to JSON.
*/
public struct TaskSaver {
  
  /*
  Writes a file to the given file name in the documents directory
  containing JSON storing the given tasks.
  
  :param: The tasks to write out.
  :param: The file name to use when writing out the file.
  */
  static func writeTasksToFile(_ tasks: [Task], fileName: FileName) {
    let dictionaries = tasks.map {
      task in
      return task.asJson()
    }
    
    var error: NSError?
    let fullFilePath = fileName.jsonFileName().pathInDocumentsDirectory()
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: dictionaries,
        options: .prettyPrinted)
        try? jsonData.write(to: URL(fileURLWithPath: fullFilePath), options: [.dataWritingAtomic])
    } catch let error1 as NSError {
      error = error1
    }
    
    if let foundError = error {
      NSLog("Error writing tasks to file: \(foundError.localizedDescription)")
    }
  }
  
  public static func nukeTaskFile(_ fileName: FileName) {
    let fullFilePath = fileName.jsonFileName().pathInDocumentsDirectory()
    var error: NSError?
    
    do {
      try FileManager.default()
        .removeItem(atPath: fullFilePath)
    } catch let error1 as NSError {
      error = error1
    }
    
    if let foundError = error {
      if foundError.code != NSFileNoSuchFileError {
        NSLog("Error deleting file: \(foundError.localizedDescription)")
      } //Otherwise the file cannot be deleted because it doesn't exist yet.
    }
  }
}
