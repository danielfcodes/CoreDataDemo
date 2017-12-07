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
    tv.separatorStyle = .none
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
  }
  
}

//MARK: Handling methods

extension CompaniesController{
  
  @objc
  private func resetBtnTapped(){
    viewModel.deleteCompanies()
  }
  
  @objc
  private func plusBtnTapped(){
    goToCreateCompanyController(willEdit: false, indexForEdit: nil)
  }
  
}

//MARK: Private methods

extension CompaniesController{
  
  private func makeBindings(){
    viewModel.didLoadCompanies = { [weak self] indexesForDelete in
      self?.reloadTableView(indexesForDelete: indexesForDelete)
    }
  }
  
  private func reloadTableView(indexesForDelete: [IndexPath]){
    if indexesForDelete.count == 0{
      tableView.reloadData()
    }else if indexesForDelete.count == 1{
      
      guard let indexPath = indexesForDelete.first else { return }
      tableView.deleteRows(at: [indexPath], with: .fade)
      
    }else{
      tableView.deleteRows(at: indexesForDelete, with: .left)
    }
  }
  
  private func goToCreateCompanyController(willEdit: Bool, indexForEdit: Int?){
    let createCompanyController = CreateCompanyController()
    createCompanyController.delegate = self
    createCompanyController.viewModel = willEdit ? viewModel.viewModelForCreateCompany(at: indexForEdit!) : CreateCompanyViewModel()
    present(UINavigationController(rootViewController: createCompanyController), animated: true, completion: nil)
  }
  
  private func goToEmployeesController(index: Int){
    let employeesController = EmployeesController()
    employeesController.viewModel = viewModel.viewModelForEmployee(at: index)
    navigationController?.pushViewController(employeesController, animated: true)
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
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let label = UnderlinedLabel()
    label.text = "No companies available"
    label.textColor = .white
    label.font = UIFont(name: Fonts.defaultFontForTitles, size: Sizes.defaultSizeForTitles)
    label.textAlignment = .center
    return label
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return viewModel.numberOfRows == 0 ? 100 : 0
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    
    let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
      self.goToCreateCompanyController(willEdit: true, indexForEdit: indexPath.row)
    }
    
    editAction.backgroundColor = Palette.viewDarkBackgroundColor
    
    let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
      self.viewModel.deleteCompany(at: indexPath.row)
    }
    
    return [deleteAction, editAction]
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    goToEmployeesController(index: indexPath.row)
  }
  
}

//MARK: UITableViewDataSource

extension CompaniesController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
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

