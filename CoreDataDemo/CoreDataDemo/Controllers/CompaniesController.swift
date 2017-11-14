//
//  HomeViewController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class CompaniesController: UIViewController{

  fileprivate lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.delegate = self
    tv.dataSource = self
    tv.backgroundColor = Palette.viewDarkBackgroundColor
    tv.register(CompanyCell.self, forCellReuseIdentifier: Identifiers.mainCell)
    return tv
  }()
  
  fileprivate var companies: [Company] = []

}

//MARK: Life cycle

extension CompaniesController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initialSetup()
    getCompanies()
  }
  
}

//MARK: Initial setup

extension CompaniesController{
  
  fileprivate func initialSetup(){
    navigationItem.title = "Companies"
    view.backgroundColor = Palette.viewDarkBackgroundColor
    addBarButtonItems()
    setupViews()
  }
  
  fileprivate func addBarButtonItems(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetBtnTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(plusBtnTapped))
  }
  
  fileprivate func setupViews(){
    setupTableView()
  }
  
  fileprivate func setupTableView(){
    view.addSubview(tableView)
    
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    addTableViewFooter()
  }
  
  fileprivate func addTableViewFooter(){
    tableView.tableFooterView = UIView()
  }
  
}

//MARK: Handling methods

extension CompaniesController{
  
  @objc
  fileprivate func resetBtnTapped(){
    print("reset")
  }
  
  @objc
  fileprivate func plusBtnTapped(){
    presentNewCompanyController()
  }
  
}

//MARK: Private methods

extension CompaniesController{
  
  fileprivate func getCompanies(){
    let apple = Company(name: "Apple", founded: Date())
    let google = Company(name: "Google", founded: Date())
    companies.append(apple)
    companies.append(google)
    tableView.reloadData()
  }
  
  fileprivate func presentNewCompanyController(){
    let createCompanyController = CreateCompanyController()
    createCompanyController.delegate = self
    present(UINavigationController(rootViewController: createCompanyController), animated: true, completion: nil)
  }
  
}

//MARK: CreateCompanyDelegate

extension CompaniesController: CreateCompanyDelegate{
  
  func createCompanyDidSave(createCompanyController: CreateCompanyController, company: Company) {
    companies.append(company)
    tableView.reloadData()
  }
  
}

//MARK: UITableViewDelegate

extension CompaniesController: UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = UIView()
    header.backgroundColor = Palette.lightBlue
    return header
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
}

//MARK: UITableViewDataSource

extension CompaniesController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return companies.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.mainCell, for: indexPath) as! CompanyCell
    cell.company = companies[indexPath.row]
    return cell
  }
  
}

//MARK: Constants

extension CompaniesController{
  
  fileprivate struct Identifiers{
    static let mainCell = "mainCell"
  }
  
}

