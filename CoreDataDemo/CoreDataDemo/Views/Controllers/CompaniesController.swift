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
  
  var viewModel: CompaniesViewModel!
}

//MARK: Life cycle

extension CompaniesController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initialSetup()
    binding()
    viewModel.getCompanies()
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
  
  fileprivate func binding(){
    viewModel.didLoadCompanies = { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  fileprivate func presentNewCompanyController(){
    let createCompanyController = CreateCompanyController()
    createCompanyController.delegate = self
    createCompanyController.viewModel = CreateCompanyViewModel()
    present(UINavigationController(rootViewController: createCompanyController), animated: true, completion: nil)
  }
  
}

//MARK: CreateCompanyDelegate

extension CompaniesController: CreateCompanyDelegate{
  
  func createCompanyDidSave(createCompanyController: CreateCompanyController) {
    viewModel.getCompanies()
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
  
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, _) in
      print("Edit company")
    }
    
    editAction.backgroundColor = Palette.viewDarkBackgroundColor
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action, sourceView, actionPerformed) in
      self.viewModel.deleteCompany(at: indexPath.row)
    }
    
    return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
  }
  
}

//MARK: UITableViewDataSource

extension CompaniesController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.companiesCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.mainCell, for: indexPath) as! CompanyCell
    cell.viewModel = viewModel.viewModelForCell(at: indexPath.row)
    return cell
  }
  
}

//MARK: Constants

extension CompaniesController{
  
  fileprivate struct Identifiers{
    static let mainCell = "mainCell"
  }
  
}

