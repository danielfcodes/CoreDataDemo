//
//  CreateCompanyController.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/12/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

protocol CreateCompanyDelegate: class{
  func createCompanyDidSave(createCompanyController: CreateCompanyController)
}

class CreateCompanyController: UIViewController, Alertable, Successful{
  
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
  
  private let datePicker: UIDatePicker = {
    let dp = UIDatePicker()
    dp.translatesAutoresizingMaskIntoConstraints = false
    dp.datePickerMode = .date
    return dp
  }()
  
  weak var delegate: CreateCompanyDelegate?
  var viewModel: CreateCompanyViewModel!{
    didSet{
      fillUI()
    }
  }
  
  let containerSuccess = ContainerSuccess()
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
  
  private func initialSetup(){
    view.backgroundColor = Palette.viewDarkBackgroundColor
    addBarButtonItems()
    setupViews()
  }
  
  private func addBarButtonItems(){
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBtnTapped))
  }
  
  private func setupViews(){
    setupContainer()
    setupNameLabel()
    setupNameTextField()
    setupDatePicker()
  }
  
  private func setupContainer(){
    view.addSubview(container)
    container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
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
  
  private func setupDatePicker(){
    container.addSubview(datePicker)
    datePicker.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
    datePicker.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
    datePicker.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
    datePicker.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 16).isActive = true
  }
  
}

//MARK: Handling methods

extension CreateCompanyController{
  
  @objc
  private func cancelBtnTapped(){
    dismiss(animated: true, completion: nil)
  }
  
  @objc
  private func saveBtnTapped(){
    guard let name = nameTextField.text, !name.isEmpty else {
      self.createDefaultAlert(message: "Favor de llenar todos los campos")
      return
    }
    
    dismissKeyboards()
    viewModel.saveCompany(name: name, founded: datePicker.date)
    delegate?.createCompanyDidSave(createCompanyController: self)
    
    UIApplication.shared.beginIgnoringInteractionEvents()
    showSuccess(message: viewModel.successMessage) {
      UIApplication.shared.endIgnoringInteractionEvents()
      self.dismiss(animated: true, completion: nil)
    }
  }
  
}

//MARK: Private methods

extension CreateCompanyController{
  
  private func dismissKeyboards(){
    nameTextField.resignFirstResponder()
  }
  
  private func fillUI(){
    navigationItem.title = viewModel.navigationTitle
    nameTextField.text = viewModel.companyName
    datePicker.date = viewModel.companyFounded
  }
  
}
