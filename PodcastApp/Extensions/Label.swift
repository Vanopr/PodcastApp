//
//  Label.swift
//  PodcastApp
//
//  Created by Vanopr on 26.09.2023.
//

import Foundation

import UIKit

extension UILabel {

  
  static func makeLabel(text: String = "", font: UIFont?, textColor: UIColor) -> UILabel {
    let label = UILabel()
    label.text = text
    label.font = font
    label.textColor = textColor
    label.adjustsFontSizeToFitWidth = true
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
    
    convenience init(labelText: String, textColor: UIColor) {
        self.init()
        self.text = labelText
        self.textColor = textColor
    }
    
}
