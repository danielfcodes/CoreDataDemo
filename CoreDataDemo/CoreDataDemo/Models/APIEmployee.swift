//
//  APIEmployee.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/13/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

struct APIEmployee: Decodable{
  let name: String
  let birthday: String
  let type: String
}
