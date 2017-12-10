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
  
  private var employees: [EmployeeViewModelItem] = []{
    didSet{
      employeesDidLoad?()
    }
  }
  
  var employeesDidLoad: (() -> Void)?
  
  //MARK: Interface
  
  var navigationTitle: String{
    return company.name ?? ""
  }
  
  var numberOfSections: Int{
    return employees.count
  }
  
  func sectionTitle(section: Int) -> String{
    return employees[section].sectionTitle
  }
  
  func numberOfRowsIn(section: Int) -> Int{
    return employees[section].rowCount
  }
  
  func viewModelForCellIn(section: Int) -> EmployeeViewModelItem{
    return employees[section]
  }
  
  func viewModelForCreateEmployee() -> CreateEmployeeViewModel{
    return CreateEmployeeViewModel(company: company)
  }
  
}

extension EmployeesViewModel{
  
  func getEmployees(){
    employees.removeAll()
    
    guard let totalEmployees = company.employees?.allObjects as? [Employee] else { return }
    let executiveEmployees = totalEmployees.filter { $0.employeeType == EmployeeViewModelItemType.executive.rawValue }
    let seniorEmployees = totalEmployees.filter { $0.employeeType == EmployeeViewModelItemType.seniorManagement.rawValue }
    let staffEmployees = totalEmployees.filter { $0.employeeType == EmployeeViewModelItemType.staff.rawValue }
    let internEmployees = totalEmployees.filter { $0.employeeType == EmployeeViewModelItemType.intern.rawValue }
    
    let executiveCellViewModel = EmployeeCellViewModel(employees: executiveEmployees, type: .executive)
    let seniorCellViewModel = EmployeeCellViewModel(employees: seniorEmployees, type: .seniorManagement)
    let staffCellViewModel = EmployeeCellViewModel(employees: staffEmployees, type: .staff)
    let internCellViewModel = EmployeeCellViewModel(employees: internEmployees, type: .intern)
    
    employees.append(executiveCellViewModel)
    employees.append(seniorCellViewModel)
    employees.append(staffCellViewModel)
    employees.append(internCellViewModel)
  }
  
}
