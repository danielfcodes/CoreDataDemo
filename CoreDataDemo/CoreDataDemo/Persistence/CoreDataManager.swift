//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/18/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import CoreData

class CoreDataManager{
  
  static let shared = CoreDataManager()
  
  var persistentContainer: NSPersistentContainer = {
    let pc = NSPersistentContainer(name: "CoreDataModel")
    pc.loadPersistentStores { (storeDescription, error) in
      
      if let error = error{
        fatalError("Loading store failed: \(error.localizedDescription)")
      }
    }
    
    return pc
  }()
  
  var viewContext: NSManagedObjectContext{
    return persistentContainer.viewContext
  }
  
  func saveMainContext(){
    guard viewContext.hasChanges else { return }
    
    do{
      try viewContext.save()
    }catch let err{
      fatalError("Error when saving mainContext \(err)")
    }
  }
  
}
