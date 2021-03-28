//
//  CustomButtonWithShadow.swift
//  TheMoviesDB
//
//  Created by Mahmut MERCAN on 27.03.2021.
//

import UIKit

class CustomButtonWithShadow: UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    // custom configuration
    self.round()
    self.shadow()
  }
  
  private func round() {
    // make it round
    self.layer.cornerRadius = 8
  }
  
  private func shadow() {
    // make it shadow
    self.layer.shadowColor = UIColor.black.cgColor
    self.layer.shadowOffset = CGSize(width: 5, height: 5)
    self.layer.shadowRadius = 3
    self.layer.shadowOpacity = 0.5
  }
  


}
