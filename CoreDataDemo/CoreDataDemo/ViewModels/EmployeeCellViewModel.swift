//
//  EmployeeCellViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/4/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

class EmployeeCellViewModel{
  
  private let employee: Employee
  
  init(employee: Employee) {
    self.employee = employee
  }
  
  //MARK: Interface
  
  var employeeName: String{
    return employee.name ?? ""
  }
  
}
