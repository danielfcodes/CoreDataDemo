//
//  NewCompanyController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/12/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {

  

}

//MARK: Life cycle

extension CreateCompanyController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initialSetup()
  }
  
}

//MARK: Initial setup

extension CreateCompanyController{
  
  fileprivate func initialSetup(){
    view.backgroundColor = Palette.viewDarkBackgroundColor
    navigationItem.title = "Create Company"
    addButtonsToNavigationItem()
  }
  
  fileprivate func addButtonsToNavigationItem(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveBtnTapped))
  }
  
}

//MARK: Handling methods

extension CreateCompanyController{
  
  @objc
  fileprivate func cancelBtnTapped(){
    dismiss(animated: true, completion: nil)
  }
  
  @objc
  fileprivate func saveBtnTapped(){
    print("SAVE COMPANY")
  }
  
}
