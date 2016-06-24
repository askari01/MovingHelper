//
//  TaskLoader.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

/*
Struct to load tasks from JSON.
*/
public struct TaskLoader {
  
  static func loadSavedTasksFromJSONFile(_ fileName: FileName) -> [Task]? {
    let path = fileName.jsonFileName().pathInDocumentsDirectory()
    if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
      return tasksFromData(data)
    } else {
      return nil
    }
  }
  
  
  /**
  - returns: The stock moving tasks included with the app.
  */
  public static func loadStockTasks() -> [Task] {
    if let path = Bundle.main()
      .pathForResource(FileName.StockTasks.rawValue, ofType: "json"),
      data = try? Data(contentsOf: URL(fileURLWithPath: path)),
      tasks = tasksFromData(data) {
        return tasks
    }
    
    //Fall through case
    NSLog("Tasks did not load!")
    return [Task]()
  }
  
  private static func tasksFromData(_ data: Data) -> [Task]? {
    do {
        let arrayOfTaskDictionaries = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary]
        return Task.tasksFromArrayOfJSONDictionaries(arrayOfTaskDictionaries!)
    } catch let error{
        print("error")
        NSLog("Error loading data: \(error)")
        return nil
    }
  }
}
