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
  
  private let taxIdLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.defaultFontForLabels, size: Sizes.defaultSizeForTitles)
    label.textColor = .white
    return label
  }()
  
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
    addSubview(taxIdLabel)
    employeeNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    employeeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    employeeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    taxIdLabel.topAnchor.constraint(equalTo: employeeNameLabel.bottomAnchor, constant: 8).isActive = true
    taxIdLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    taxIdLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
  //MARK: Private methods
  
  private func fillUI(){
    employeeNameLabel.text = viewModel.employeeName
    taxIdLabel.text = viewModel.taxId
  }
  
}

