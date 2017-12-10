//
//  EmployeeCellViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/4/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

class EmployeeCellViewModel: EmployeeViewModelItem{
  
  private let employees: [Employee]
  private let type: EmployeeViewModelItemType
  
  init(employees: [Employee], type: EmployeeViewModelItemType) {
    self.employees = employees
    self.type = type
  }
  
  var rowCount: Int{
    return employees.count
  }
  
  var sectionTitle: String{
    return type.rawValue
  }
  
  //MARK: Interface
  
  func employeeName(at index: Int) -> String{
    return employees[index].name ?? ""
  }

  func birthday(at index: Int) -> String{
    guard let birthday = employees[index].employeeInformation?.birthday else { return "" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd, yyyy"
    let birthdayString = dateFormatter.string(from: birthday)
    return "Birthday: \(birthdayString)"
  }
  
}
