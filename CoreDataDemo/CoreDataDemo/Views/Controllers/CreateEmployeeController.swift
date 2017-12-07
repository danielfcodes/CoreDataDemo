//
//  CreateEmployeeController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/4/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

protocol CreateEmployeeControllerDelegate: class{
  func createEmployeeDidSave(_ createEmployeeController: CreateEmployeeController)
}

class CreateEmployeeController: UIViewController, Successful{
  
  private let container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = Palette.lightBlue
    return view
  }()
  
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Name"
    label.textColor = .darkGray
    label.font = UIFont(name: Fonts.defaultFontForLabels, size: Sizes.defaultSizeForLabels)
    return label
  }()
  
  private let nameTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "Enter name"
    return textField
  }()
  
  var viewModel: CreateEmployeeViewModel!
  weak var delegate: CreateEmployeeControllerDelegate?
  let containerSuccess = ContainerSuccess()
}

//MARK: Life cycle

extension CreateEmployeeController{
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initialSetup()
  }
  
}

//MARK: Initial setup

extension CreateEmployeeController{
  
  private func initialSetup(){
    navigationItem.title = viewModel.navigationTitle
    view.backgroundColor = Palette.viewDarkBackgroundColor
    setupBarButtons()
    setupViews()
  }
  
  private func setupBarButtons(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnTapped))
  }
  
  private func setupViews(){
    setupContainer()
    setupNameLabel()
    setupNameTextField()
  }
  
  private func setupContainer(){
    view.addSubview(container)
    container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
  }
  
  private func setupNameLabel(){
    container.addSubview(nameLabel)
    nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForLabels).isActive = true
  }
  
  private func setupNameTextField(){
    container.addSubview(nameTextField)
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
    nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForTextFields).isActive = true
  }
  
}

//MARK: Handling methods

extension CreateEmployeeController{
  
  @objc
  private func cancelBtnTapped(){
    dismiss(animated: true, completion: nil)
  }
  
  @objc
  private func saveBtnTapped(){
    guard let name = nameTextField.text, !name.isEmpty else { return }
    dismissKeyboards()
    viewModel.saveCompany(name: name)
    delegate?.createEmployeeDidSave(self)
    
    UIApplication.shared.beginIgnoringInteractionEvents()
    showSuccess(message: viewModel.successMessage) {
      UIApplication.shared.endIgnoringInteractionEvents()
      self.dismiss(animated: true, completion: nil)
    }
  }
  
}

//MARK: Private methods

extension CreateEmployeeController{
  
  private func dismissKeyboards(){
    nameTextField.resignFirstResponder()
  }
  
}
