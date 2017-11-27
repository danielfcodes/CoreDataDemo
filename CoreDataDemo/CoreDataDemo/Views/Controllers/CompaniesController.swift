//
//  HomeViewController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class CompaniesController: UIViewController{

  private lazy var tableView: UITableView = {
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
    makeBindings()
    viewModel.getCompanies()
  }
  
}

//MARK: Initial setup

extension CompaniesController{
  
  private func initialSetup(){
    navigationItem.title = "Companies"
    view.backgroundColor = Palette.viewDarkBackgroundColor
    addBarButtonItems()
    setupViews()
  }
  
  private func addBarButtonItems(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetBtnTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(plusBtnTapped))
  }
  
  private func setupViews(){
    setupTableView()
  }
  
  private func setupTableView(){
    view.addSubview(tableView)
    
    tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    addTableViewFooter()
  }
  
  private func addTableViewFooter(){
    tableView.tableFooterView = UIView()
  }
  
}

//MARK: Handling methods

extension CompaniesController{
  
  @objc
  private func resetBtnTapped(){
    print("reset")
  }
  
  @objc
  private func plusBtnTapped(){
    presentNewCompanyController(willEdit: false, indexForEdit: nil)
  }
  
}

//MARK: Private methods

extension CompaniesController{
  
  private func makeBindings(){
    viewModel.didLoadCompanies = { [weak self] indexForDelete in
      self?.reloadTableView(indexForDelete: indexForDelete)
    }
  }
  
  private func reloadTableView(indexForDelete: Int?){
    if let indexForDelete = indexForDelete{
      let indexPath = IndexPath(row: indexForDelete, section: 0)
      tableView.deleteRows(at: [indexPath], with: .fade)
    }else{
      tableView.reloadData()
    }
  }
  
  private func presentNewCompanyController(willEdit: Bool, indexForEdit: Int?){
    let createCompanyController = CreateCompanyController()
    createCompanyController.delegate = self
    createCompanyController.viewModel = willEdit ? viewModel.viewModelForCreateCompany(at: indexForEdit!) : CreateCompanyViewModel()
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
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
      self.presentNewCompanyController(willEdit: true, indexForEdit: indexPath.row)
    }
    
    editAction.backgroundColor = Palette.viewDarkBackgroundColor
    
    let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
      self.viewModel.deleteCompany(at: indexPath.row)
    }
    
    return [deleteAction, editAction]
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
  
  private struct Identifiers{
    static let mainCell = "mainCell"
  }
  
}

