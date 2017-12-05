//
//  EmployeesViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/4/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

class EmployeesViewModel{
  
  private let company: Company
  
  init(company: Company) {
    self.company = company
  }
  
  //MARK: Interface
  
  var navigationTitle: String{
    return company.name ?? ""
  }
  
}
