//
//  CreateEmployeeViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/6/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import CoreData

class CreateEmployeeViewModel{
  
  private let company: Company
  
  init(company: Company) {
    self.company = company
  }
  
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
    let employee = Employee(context: context)
    let employeeInformation = EmployeeInformation(context: context)
    employeeInformation.taxId = "456"
    
    employee.name = name
    employee.company = company
    employee.employeeInformation = employeeInformation
    
    do{
      try context.save()
    }catch{
      fatalError("Error when creating employee")
    }
  }
  
}
