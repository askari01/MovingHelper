//
//  FileLoadingStringExtension.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/15/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/*
An extension to facilitate creating paths based on the receiving string.
*/
extension String {
  
  /*
  Appends the receiver as a path component to the path of the NSDocumentDirectory.
  
  :returns: The full path to the receiver in the NSDocumentDirectory
  */
  func pathInDocumentsDirectory() -> String {
    let urls = FileManager.default().urlsForDirectory(.documentDirectory, inDomains: .userDomainMask)
    if let last = urls.last,
        documentsDirectory = last.path {
        return (documentsDirectory as NSString).appendingPathComponent(self)
    }
    
    //Fall-through
    return self
  }
}
