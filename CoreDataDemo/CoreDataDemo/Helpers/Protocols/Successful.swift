//
//  Successful.swift
//  CoreDataDemo
//
//  Created by Daniel Fernandez on 11/25/17.
//  Copyright © 2017 Ronteq. All rights reserved.
//

import UIKit

func delay(_ seconds: Double, completion: @escaping() -> Void){
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

protocol Successful: class{
  var containerSuccess: ContainerSuccess { get }
  func showSuccess(message: String, completion: @escaping() -> Void)
}

extension Successful where Self: UIViewController{
  
  func showSuccess(message: String, completion: @escaping() -> Void){
    containerSuccess.messageLabel.text = message
    view.addSubview(containerSuccess)
    containerSuccess.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    containerSuccess.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    containerSuccess.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
    containerSuccess.heightAnchor.constraint(equalToConstant: 100).isActive = true
    containerSuccess.start()
    delay(2) {
      self.hideSuccess(){
        completion()
      }
    }
  }
  
  func hideSuccess(completion: @escaping()-> Void){
    containerSuccess.hide {
      self.containerSuccess.removeFromSuperview()
      completion()
    }
  }
  
}

class ContainerSuccess: ShadowView{
  
  private let successLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Success"
    label.textColor = .white
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  let messageLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 14)
    label.numberOfLines = 2
    label.minimumScaleFactor = 0.1
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = UIColor(red: 97/255, green: 161/255, blue: 24/255, alpha: 1.0)
    layer.cornerRadius = 10
    alpha = 0.0
    setupBottomShadow()
    setupLabels()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("Error coder on ContainerSuccess")
  }
  
  private func setupLabels(){
    addSubview(successLabel)
    addSubview(messageLabel)
    
    messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 16).isActive = true
    
    successLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    successLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
    successLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -16).isActive = true
  }
  
  func start(){
    UIView.animate(withDuration: 0.5) {
      self.alpha = 1.0
    }
  }
  
  func hide(completion: @escaping() -> Void){
    UIView.animate(withDuration: 0.5, animations: {
      self.alpha = 0.0
    }) { (_) in
      completion()
    }
  }
  
}
