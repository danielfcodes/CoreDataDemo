//
//  ShadowView.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/25/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class ShadowView: UIView{
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.masksToBounds = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
  }
  
  func setupTopShadow(){
    layer.shadowOffset = CGSize(width: 0, height: -1)
    layer.shadowRadius = 3
    layer.shadowOpacity = 0.2
  }
  
  func setupBottomShadow(){
    layer.shadowOffset = CGSize(width: 0, height: 4)
    layer.shadowRadius = 3
    layer.shadowOpacity = 0.2
  }
  
  func setupShadow(){
    layer.shadowOpacity = 0.4
    layer.shadowOffset = CGSize(width: 2, height: 2)
  }
}
