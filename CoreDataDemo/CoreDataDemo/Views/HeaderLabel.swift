//
//  HeaderLabel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 12/9/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class HeaderLabel: UILabel{
  
  override func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    let customRect = UIEdgeInsetsInsetRect(rect, insets)
    super.drawText(in: customRect)
  }
  
}
