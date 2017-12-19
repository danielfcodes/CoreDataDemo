//
//  CompanyService.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/13/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation

struct CompanyService{
  
  let apiEndpoint = "https://api.letsbuildthatapp.com/intermediate_training/companies"
  
  func getCompanies(completion: @escaping(_ companies: [APICompany]) -> Void){
    print("download companies from network...")
    guard let url = URL(string: apiEndpoint) else { return }
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
      guard error == nil else { return }
      guard let data = data else { return }
      
      let jsonDecoder = JSONDecoder()
      
      do{
        let jsonCompanies = try jsonDecoder.decode([APICompany].self, from: data)
        completion(jsonCompanies)
      }catch let err{
        print("Error when downloading companies \(err)")
      }
      
    }
    
    task.resume()
  }
  
}


