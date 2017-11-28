//
//  CompanyCell.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell{
  
  fileprivate let companyNameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.defaultFontForTitles, size: Sizes.defaultSizeForTitles)
    label.textColor = .white
    return label
  }()
  
  private let companyFoundedLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.defaultFontForLabels, size: Sizes.defaultSizeForLabels)
    label.textColor = .white
    return label
  }()
  
  var viewModel: CompanyCellViewModel!{
    didSet{
      fillUI()
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = Palette.tealColor
    separatorInset = UIEdgeInsets.zero
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Error coder on CompanyCell")
  }
  
  //MARK: Initial setup
  
  fileprivate func setupViews(){
    addSubview(companyNameLabel)
    addSubview(companyFoundedLabel)
    companyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
    companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    
    companyFoundedLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 8).isActive = true
    companyFoundedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    companyFoundedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
  //MARK: Private methods
  
  fileprivate func fillUI(){
    companyNameLabel.text = viewModel.companyName
    companyFoundedLabel.text = "Founded: \(viewModel.companyFounded)"
  }
  
}
