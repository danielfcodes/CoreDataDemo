//
//  EmployeesController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/4/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class EmployeesController: UIViewController{
  
  private lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.delegate = self
    tv.dataSource = self
    tv.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.identifier)
    tv.backgroundColor = Palette.viewDarkBackgroundColor
    tv.separatorStyle = .none
    return tv
  }()
  
  var viewModel: EmployeesViewModel!{
    didSet{
      fillUI()
    }
  }
  
}

//MARK: Life cycle

extension EmployeesController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
    makeBindings()
  }
  
}

//MARK: Initial setup

extension EmployeesController{
  
  private func initialSetup(){
    view.backgroundColor = Palette.viewDarkBackgroundColor
    setupBarButtons()
    setupViews()
  }
  
  private func setupBarButtons(){
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus"), style: .plain, target: self, action: #selector(plusBtnTapped))
  }
  
  private func setupViews(){
    setupTableView()
  }
  
  private func setupTableView(){
    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
}

//MARK: Handling methods

extension EmployeesController{
  
  @objc
  private func plusBtnTapped(){
    goToCreateEmployeeController(willEdit: false)
  }
  
}

//MARK: Private methods

extension EmployeesController{
  
  private func makeBindings(){
    viewModel.employeesDidLoad = { [weak self] in
      self?.tableView.reloadData()
    }
  }
  
  private func fillUI(){
    navigationItem.title = viewModel.navigationTitle
  }
  
  private func goToCreateEmployeeController(willEdit: Bool){
    let createEmployeeController = CreateEmployeeController()
    createEmployeeController.delegate = self
    createEmployeeController.viewModel = viewModel.viewModelForCreateEmployee()
    present(UINavigationController(rootViewController: createEmployeeController), animated: true, completion: nil)
  }
  
}

//MARK: CreateEmployeeControllerDelegate

extension EmployeesController: CreateEmployeeControllerDelegate{
  
  func createEmployeeDidSave(_ createEmployeeController: CreateEmployeeController) {
    viewModel.getEmployees()
  }
  
}

//MARK: UITableViewDelegate

extension EmployeesController: UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
}

//MARK: UITableViewDataSource

extension EmployeesController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as! EmployeeCell
    cell.viewModel = viewModel.viewModelForCell(at: indexPath.row)
    return cell
  }
  
}
