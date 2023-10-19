//
//  UITextField.swift
//  PodcastApp
//
//  Created by Ислам Пулатов on 9/26/23.
//

import UIKit

extension UITextField {
    
    convenience init(placeholder: String, borderStyle: UITextField.BorderStyle) {
        self.init()
        self.placeholder = placeholder
        self.borderStyle = borderStyle
    }
    
}
