//
//  CreateEmployeeViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/6/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import CoreData

class CreateEmployeeViewModel{
  
  var employee: Employee?
  
  //MARK: Interface
  
  var navigationTitle: String{
    return employee != nil ? "Edit Employee" : "Create Employee"
  }
  
  var successMessage: String{
    return employee != nil ? "Empleado actualizad de manera exitosa" : "Empleado creado de manera exitosa"
  }
  
}

extension CreateEmployeeViewModel{
  
  func saveCompany(name: String){
    if employee == nil{
      createEmployee(name: name)
    }else{
      
    }
  }
  
  private func createEmployee(name: String){
    let context = CoreDataManager.shared.viewContext
    let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
    employee.setValue(name, forKey: "name")
    
    do{
      try context.save()
    }catch{
      fatalError("Error when creating employee")
    }
  }
  
}
