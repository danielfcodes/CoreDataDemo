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
    goToCreateEmployeeController()
  }
  
}

//MARK: Private methods

extension EmployeesController{
  
  private func fillUI(){
    navigationItem.title = viewModel.navigationTitle
  }
  
  private func goToCreateEmployeeController(){
    let createEmployeeController = CreateEmployeeController()
    //delegate
    //Viewmodel
    present(UINavigationController(rootViewController: createEmployeeController), animated: true, completion: nil)
  }
  
}

//MARK: UITableViewDelegate

extension EmployeesController: UITableViewDelegate{
  
  
  
}

//MARK: UITableViewDataSource

extension EmployeesController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as! EmployeeCell
//    cell.viewModel = viewModel.viewModelForCell(at: indexPath.row)
    return cell
  }
  
}
