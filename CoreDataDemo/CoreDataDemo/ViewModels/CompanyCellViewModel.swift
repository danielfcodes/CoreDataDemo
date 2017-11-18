//
//  CompanyCellViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/18/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

class CompanyCellViewModel{
  
  fileprivate let company: Company
  
  init(company: Company) {
    self.company = company
  }
  
  //MARK: Interface
  
  var companyName: String?{
    return company.name
  }
  
}