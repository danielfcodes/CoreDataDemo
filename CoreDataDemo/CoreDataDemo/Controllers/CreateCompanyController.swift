//
//  CreateCompanyController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/12/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

protocol CreateCompanyDelegate: class{
  func createCompanyDidSave(createCompanyController: CreateCompanyController, company: Company)
}

class CreateCompanyController: UIViewController, Alertable{
  
  fileprivate let container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = Palette.lightBlue
    return view
  }()
  
  fileprivate let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Name"
    label.textColor = .darkGray
    label.font = UIFont(name: Fonts.defaultFontForLabels, size: Sizes.defaultSizeForLabels)
    return label
  }()
  
  fileprivate let nameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Enter name"
    return textField
  }()
  
  weak var delegate: CreateCompanyDelegate?
  
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
    addBarButtonItems()
    setupViews()
  }
  
  fileprivate func addBarButtonItems(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnTapped))
  }
  
  fileprivate func setupViews(){
    setupContainer()
    setupNameLabel()
    setupNameTextField()
  }
  
  fileprivate func setupContainer(){
    view.addSubview(container)
    container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
  }
  
  fileprivate func setupNameLabel(){
    container.addSubview(nameLabel)
    nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
  }
  
  fileprivate func setupNameTextField(){
    container.addSubview(nameTextField)
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
    nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForTextFields).isActive = true
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
    guard let name = nameTextField.text, !name.isEmpty else {
      self.createDefaultAlert(message: "Favor de llenar todos los campos")
      return
    }
    let newCompany = Company(name: name, founded: Date())
    delegate?.createCompanyDidSave(createCompanyController: self, company: newCompany)
    dismiss(animated: true, completion: nil)
  }
  
}
