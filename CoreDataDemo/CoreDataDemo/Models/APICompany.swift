//
//  APICompany.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

struct APICompany: Decodable{
  let name: String
  let photoUrl: String
  let founded: String
  var employees: [APIEmployee]?
}

