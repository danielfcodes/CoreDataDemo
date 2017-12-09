//
//  EmployeesViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/4/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import CoreData

class EmployeesViewModel{
  
  private let company: Company
  
  init(company: Company) {
    self.company = company
    getEmployees()
  }
  
  private var employees: [Employee] = []{
    didSet{
      employeesDidLoad?()
    }
  }
  
  var employeesDidLoad: (() -> Void)?
  
  //MARK: Interface
  
  var navigationTitle: String{
    return company.name ?? ""
  }
  
  var numberOfRows: Int{
    return employees.count
  }
  
  func viewModelForCell(at index: Int) -> EmployeeCellViewModel{
    return EmployeeCellViewModel(employee: employees[index])
  }
  
  func viewModelForCreateEmployee() -> CreateEmployeeViewModel{
    return CreateEmployeeViewModel(company: company)
  }
  
}

extension EmployeesViewModel{
  
  func getEmployees(){
    guard let companyEmployees = company.employees?.allObjects as? [Employee] else { return }
    employees = companyEmployees
  }
  
}
