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
  
  private let birthdayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Birthday"
    label.textColor = .darkGray
    label.font = UIFont(name: Fonts.defaultFontForLabels, size: Sizes.defaultSizeForLabels)
    return label
  }()
  
  private let birthdayTextField: UITextField = {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.placeholder = "MM/DD/YYYY"
    return textField
  }()
  
  private lazy var employeeTypeSegmentedControl: UISegmentedControl = {
    let sc = UISegmentedControl(items: [
      EmployeeViewModelItemType.executive.rawValue,
      EmployeeViewModelItemType.seniorManagement.rawValue,
      EmployeeViewModelItemType.staff.rawValue,
      EmployeeViewModelItemType.intern.rawValue])
    
    sc.translatesAutoresizingMaskIntoConstraints = false
    sc.tintColor = Palette.viewDarkBackgroundColor
    sc.selectedSegmentIndex = 0
    return sc
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
    setupNameComponents()
    setupBirthdayComponents()
    setupSegmentedControl()
  }
  
  private func setupContainer(){
    view.addSubview(container)
    container.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    container.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
  }
  
  private func setupNameComponents(){
    container.addSubview(nameLabel)
    container.addSubview(nameTextField)
    
    nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
    nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForLabels).isActive = true
    
    nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
    nameTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
    nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor).isActive = true
    nameTextField.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForTextFields).isActive = true
  }
  
  private func setupBirthdayComponents(){
    container.addSubview(birthdayLabel)
    container.addSubview(birthdayTextField)
    
    birthdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24).isActive = true
    birthdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    birthdayLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    birthdayLabel.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForLabels).isActive = true
    
    birthdayTextField.leadingAnchor.constraint(equalTo: birthdayLabel.trailingAnchor).isActive = true
    birthdayTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
    birthdayTextField.centerYAnchor.constraint(equalTo: birthdayLabel.centerYAnchor).isActive = true
    birthdayTextField.heightAnchor.constraint(equalToConstant: Sizes.defaultSizeForTextFields).isActive = true
  }
  
  private func setupSegmentedControl(){
    container.addSubview(employeeTypeSegmentedControl)
    employeeTypeSegmentedControl.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 24).isActive = true
    employeeTypeSegmentedControl.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
    employeeTypeSegmentedControl.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
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
    guard let name = nameTextField.text, !name.isEmpty,
      let birthday = birthdayTextField.text, !birthday.isEmpty else { return }
    dismissKeyboards()
    
    guard let birthdayDate = getDate(from: birthday) else {
      print("can't create date from that string")
      return
    }
    
    guard let employeeType = employeeTypeSegmentedControl.titleForSegment(at: employeeTypeSegmentedControl.selectedSegmentIndex) else { return }
    
    viewModel.saveEmployee(name: name, birthday: birthdayDate, employeeType: employeeType)
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
  
  private func getDate(from stringDate: String) -> Date?{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    return dateFormatter.date(from: stringDate)
  }
  
}
