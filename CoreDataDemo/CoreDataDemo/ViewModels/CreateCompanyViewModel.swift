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
  
  var company: Company?
  
  func saveCompany(name: String, founded: Date){
    if company == nil{
      createCompany(name: name, founded: founded)
    }else{
      updateCompany(name: name, founded: founded)
    }
  }
  
  var navigationTitle: String{
    return company != nil ? "Edit Company" : "Create Company"
  }
  
  var successMessage: String{
    return company != nil ? "Compañía actualizada de manera exitosa" : "Compañía creada de manera exitosa"
  }
  
  var companyName: String?{
    return company?.name
  }
  
}

extension CreateCompanyViewModel{
  
  private func createCompany(name: String, founded: Date){
    let context = CoreDataManager.shared.viewContext
    let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
    company.setValue(name, forKey: "name")
    company.setValue(founded, forKey: "founded")
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
  private func updateCompany(name: String, founded: Date){
    company?.name = name
    company?.founded = founded
    let context = CoreDataManager.shared.viewContext
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
}
