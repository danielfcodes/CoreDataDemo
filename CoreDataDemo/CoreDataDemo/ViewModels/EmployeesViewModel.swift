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
  
}

extension EmployeesViewModel{
  
  func getEmployees(){
    let context = CoreDataManager.shared.viewContext
    let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
    
    do{
      self.employees = try context.fetch(fetchRequest)
    }catch let err{
      print("Failed to fetch companies \(err.localizedDescription)")
    }
  }
  
}
