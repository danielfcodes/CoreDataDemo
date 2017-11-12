//
//  HomeViewController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

  fileprivate lazy var tableView: UITableView = {
    let tv = UITableView()
    tv.translatesAutoresizingMaskIntoConstraints = false
    tv.delegate = self
    tv.dataSource = self
    tv.backgroundColor = Palette.viewDarkBackgroundColor
    tv.register(CompanyCell.self, forCellReuseIdentifier: Identifiers.mainCell)
    return tv
  }()

}

//MARK: Life cycle

extension HomeViewController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initialSetup()
  }
  
}

//MARK: Initial setup

extension HomeViewController{
  
  fileprivate func initialSetup(){
    navigationItem.title = "Companies"
    view.backgroundColor = Palette.viewDarkBackgroundColor
    addButtonsToNavigationTem()
    setupViews()
  }
  
  fileprivate func addButtonsToNavigationTem(){
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

extension HomeViewController{
  
  @objc
  fileprivate func resetBtnTapped(){
    print("reset")
  }
  
  @objc
  fileprivate func plusBtnTapped(){
    print("PLUS")
  }
  
}

//MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate{
  
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

extension HomeViewController: UITableViewDataSource{
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.mainCell, for: indexPath) as! CompanyCell
    return cell
  }
  
}

//MARK: Constants

extension HomeViewController{
  
  fileprivate struct Identifiers{
    static let mainCell = "mainCell"
  }
  
}

