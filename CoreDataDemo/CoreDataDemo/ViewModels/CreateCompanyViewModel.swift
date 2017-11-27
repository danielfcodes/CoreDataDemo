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
  
  func saveCompany(name: String){
    if company == nil{
      createCompany(name: name)
    }else{
      updateCompany(name: name)
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
  
  private func createCompany(name: String){
    let context = CoreDataManager.shared.viewContext
    let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
    company.setValue(name, forKey: "name")
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
  private func updateCompany(name: String){
    company?.name = name
    let context = CoreDataManager.shared.viewContext
    
    do{
      try context.save()
    }catch let err{
      print("Can't save the company \(err.localizedDescription)")
    }
  }
  
}
