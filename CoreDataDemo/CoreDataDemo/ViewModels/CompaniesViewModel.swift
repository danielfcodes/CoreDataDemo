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
  
  private let companyService: CompanyService
  
  init(companyService: CompanyService) {
    self.companyService = companyService
  }
  
  private var companies: [Company] = []{
    didSet{
      didLoadCompanies?(indexesForDelete)
      indexesForDelete.removeAll()
    }
  }
  
  var didLoadCompanies: ((_ indexesForDelete: [IndexPath]) -> Void)?
  var indexesForDelete: [IndexPath] = []
  
  //MARK: Interface
  
  var numberOfRows: Int{
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
  
  func viewModelForEmployee(at index: Int) -> EmployeesViewModel{
    return EmployeesViewModel(company: companies[index])
  }
}

extension CompaniesViewModel{
  
  func getCompanies(){
    let context = CoreDataManager.shared.viewContext
    let request: NSFetchRequest<Company> = Company.fetchRequest()
    
    do{
      self.companies = try context.fetch(request)
    }catch let err{
      print("Failed to fetch companies \(err.localizedDescription)")
    }
  }
  
  func deleteCompany(at index: Int){
    fillIndexesForDelete(with: index)
    
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
  
  func deleteCompanies(){
    fillIndexesForDelete()
    let context  = CoreDataManager.shared.viewContext
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
    
    do{
      try context.execute(batchDeleteRequest)
      companies.removeAll()
    }catch let err{
      print("Failed to remove all companies \(err.localizedDescription)")
    }
    
  }
  
  private func fillIndexesForDelete(with index: Int){
    let indexPath = IndexPath(row: index, section: 0)
    indexesForDelete.append(indexPath)
  }
  
  private func fillIndexesForDelete(){
    for (index, _) in companies.enumerated(){
      let indexPath = IndexPath(row: index, section: 0)
      indexesForDelete.append(indexPath)
    }
  }
  
}

//MARK: Networking methods

extension CompaniesViewModel{
  
  func getCompaniesFromNetwork(){
    
    companyService.getCompanies { (apiCompanies) in
      let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
      privateContext.parent = CoreDataManager.shared.viewContext
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MM/dd/yyyy"
      
      apiCompanies.forEach({ (apiCompany) in
        
        let company = Company(context: privateContext)
        company.name = apiCompany.name
        company.founded = dateFormatter.date(from: apiCompany.founded)
        
        apiCompany.employees?.forEach({ (apiEmployee) in
          let employee = Employee(context: privateContext)
          employee.name = apiEmployee.name
          employee.employeeType = apiEmployee.type
          
          let employeeInformation = EmployeeInformation(context: privateContext)
          employeeInformation.birthday = dateFormatter.date(from: apiEmployee.birthday)
          
          employee.employeeInformation = employeeInformation
          employee.company = company
        })
        
        do{
          try privateContext.save()
          try privateContext.parent?.save()
          self.getCompanies()
        }catch let err{
          print("Failed to save companies: \(err)")
        }
      })
      
      
    }
  }
  
}
