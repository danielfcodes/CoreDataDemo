//
//  EmployeeCell.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell{
  
  static let identifier = "EmployeeCell"
  
  private let employeeNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.defaultFontForTitles, size: Sizes.defaultSizeForTitles)
    label.textColor = .white
    return label
  }()
  
  private let birthdayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.defaultFontForLabels, size: Sizes.defaultSizeForTitles)
    label.textColor = .white
    return label
  }()
  
  var index: Int?
  var viewModel: EmployeeCellViewModel!{
    didSet{
      fillUI()
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = Palette.tealColor
    selectionStyle = .none
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Error coder on CompanyCell")
  }
  
  //MARK: Initial setup
  
  private func setupViews(){
    addSubview(employeeNameLabel)
    addSubview(birthdayLabel)
    employeeNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    employeeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    birthdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    birthdayLabel.leadingAnchor.constraint(equalTo: employeeNameLabel.trailingAnchor, constant: 16).isActive = true
    birthdayLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
  //MARK: Private methods
  
  private func fillUI(){
    guard let index = index else { return }
    employeeNameLabel.text = viewModel.employeeName(at: index)
    birthdayLabel.text = viewModel.birthday(at: index)
  }
  
}

