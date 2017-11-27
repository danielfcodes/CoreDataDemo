//
//  CompaniesViewModel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/18/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import Foundation
import CoreData

class CompaniesViewModel{
  
  private var companies: [Company] = []{
    didSet{
      didLoadCompanies?(indexForDelete)
      indexForDelete = nil
    }
  }
  
  var didLoadCompanies: ((_ indexForDelete: Int?) -> Void)?
  var indexForDelete: Int?
  
  //MARK: Interface
  
  var companiesCount: Int{
    return companies.count
  }
  
  func viewModelForCell(at index: Int) -> CompanyCellViewModel{
    return CompanyCellViewModel(company: companies[index])
  }
  
  func viewModelForCreateCompany(at index: Int) -> CreateCompanyViewModel{
    let viewModel = CreateCompanyViewModel()
    viewModel.company = companies[index]
    return viewModel
  }
}

extension CompaniesViewModel{

  func getCompanies(){
    let context = CoreDataManager.shared.viewContext
    let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
    
    do{
      self.companies = try context.fetch(fetchRequest)
    }catch let err{
      print("Failed to fetch companies \(err.localizedDescription)")
    }
  }
  
  func deleteCompany(at index: Int){
    indexForDelete = index
    let company = companies[index]
    let context = CoreDataManager.shared.viewContext
    context.delete(company)
    do{
      try context.save()
      companies.remove(at: index)
    }catch let err{
      print("Failed to remove company \(err.localizedDescription)")
    }
  }
  
}
