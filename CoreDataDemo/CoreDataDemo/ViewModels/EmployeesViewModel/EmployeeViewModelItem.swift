//
//  EmployeeViewModelItem.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/10/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

protocol EmployeeViewModelItem{
  var rowCount: Int { get }
  var sectionTitle: String { get }
}

extension EmployeeViewModelItem{
  var rowCount: Int{
    return 1
  }
}
