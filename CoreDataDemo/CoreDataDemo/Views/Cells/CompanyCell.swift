//
//  CompanyCell.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/11/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell{
  
  private let companyImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFill
    iv.layer.cornerRadius = 40
    iv.clipsToBounds = true
    return iv
  }()
  
  private let companyNameLabel: UILabel = {
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
    selectionStyle = .none
    separatorInset = UIEdgeInsets.zero
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Error coder on CompanyCell")
  }
  
  //MARK: Initial setup
  
  private func setupViews(){
    addSubview(companyNameLabel)
    addSubview(companyFoundedLabel)
    addSubview(companyImageView)
    
    companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    companyImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8).isActive = true
    companyImageView.widthAnchor.constraint(equalTo: companyImageView.heightAnchor, multiplier: 1).isActive = true
    companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
    companyNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
    companyNameLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 16).isActive = true
    companyNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    
    companyFoundedLabel.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 8).isActive = true
    companyFoundedLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 16).isActive = true
    companyFoundedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
  }
  
  //MARK: Private methods
  
  private func fillUI(){
    companyNameLabel.text = viewModel.companyName
    companyFoundedLabel.text = "Founded: \(viewModel.companyFounded)"
    
    if let imageData = viewModel.imageData{
      companyImageView.image = UIImage(data: imageData)
    }
  }
  
}
