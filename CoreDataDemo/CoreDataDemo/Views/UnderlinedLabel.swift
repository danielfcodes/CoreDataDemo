//
//  UnderlinedLabel.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/28/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

class UnderlinedLabel: UILabel {
  
  override var text: String? {
    didSet {
      guard let text = text else { return }
      let textRange = NSMakeRange(0, text.count)
      let attributedText = NSMutableAttributedString(string: text)
      attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
      self.attributedText = attributedText
    }
  }
}
