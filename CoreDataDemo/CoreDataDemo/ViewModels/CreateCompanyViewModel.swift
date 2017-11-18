//
//  CreateCompanyViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/18/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation
import CoreData

class CreateCompanyViewModel{
  
  func saveCompany(name: String){
    let context = CoreDataManager.shared.viewContext
    let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
    company.setValue(name, forKey: "name")
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
}
