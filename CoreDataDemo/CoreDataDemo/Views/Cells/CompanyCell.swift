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
    label.backgroundColor = .white
    label.font = UIFont(name: Fonts.defaultFontForTitles, size: Sizes.defaultSizeForTitles)
    label.text = "Apple"
    label.backgroundColor = .clear
    label.textColor = .white
    return label
  }()
  
  var company: Company!{
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
    companyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    companyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
  //MARK: Private methods
  
  fileprivate func fillUI(){
    companyNameLabel.text = company.name
  }
  
}
