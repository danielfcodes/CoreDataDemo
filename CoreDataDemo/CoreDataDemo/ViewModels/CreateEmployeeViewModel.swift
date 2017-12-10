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
  
  func saveEmployee(name: String, birthday: Date, employeeType: String){
    if employee == nil{
      createEmployee(name: name, birthday: birthday, employeeType: employeeType)
    }else{
      //TODO: Update employee method
    }
  }
  
  private func createEmployee(name: String, birthday: Date, employeeType: String){
    let context = CoreDataManager.shared.viewContext
    let employee = Employee(context: context)
    let employeeInformation = EmployeeInformation(context: context)
    employeeInformation.birthday = birthday
    
    employee.name = name
    employee.employeeType = employeeType
    employee.company = company
    employee.employeeInformation = employeeInformation
    
    do{
      try context.save()
    }catch{
      fatalError("Error when creating employee")
    }
  }
  
}
