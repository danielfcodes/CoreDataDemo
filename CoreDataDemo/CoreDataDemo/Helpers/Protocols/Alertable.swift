//
//  Alertable.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/13/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

protocol Alertable: class{
  
  func createDefaultAlert(message: String)
  
}

extension Alertable where Self: UIViewController{
  
  func createDefaultAlert(message: String){
    let alert = UIAlertController(title: "DF", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    
    self.present(alert, animated: true, completion: nil)
  }
  
}
